-- Drop table if it exists to start fresh
drop table if exists public.simulator_latest cascade;

-- Create table with RLS enabled for security
create table public.simulator_latest (
  key text primary key,
  problem jsonb not null,
  answer jsonb not null,
  candidates jsonb not null,
  updated_at timestamptz not null default now()
);

-- Enable RLS for security
alter table public.simulator_latest enable row level security;

-- Grant table-level permissions to roles
grant select, insert, update, delete on public.simulator_latest to anon;
grant select, insert, update, delete on public.simulator_latest to authenticated;

-- Policy for anonymous users: can do anything (for public simulator)
create policy "anon_all_access" on public.simulator_latest
  for select using (auth.role() = 'anon' OR auth.role() = 'authenticated');

create policy "anon_insert_update" on public.simulator_latest
  for insert with check (auth.role() = 'anon' OR auth.role() = 'authenticated');

create policy "anon_update" on public.simulator_latest
  for update using (auth.role() = 'anon' OR auth.role() = 'authenticated');

-- Policy for authenticated users: can do anything
create policy "authenticated_all_access" on public.simulator_latest
  for select using (auth.role() = 'authenticated');

create policy "authenticated_insert_update" on public.simulator_latest
  for insert with check (auth.role() = 'authenticated');

create policy "authenticated_update" on public.simulator_latest
  for update using (auth.role() = 'authenticated');