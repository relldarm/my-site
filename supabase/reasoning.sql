create table if not exists public.reasoning_latest (
  type text primary key,
  problem jsonb not null,
  answer jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.reasoning_latest enable row level security;

grant usage on schema public to anon, authenticated;
grant select, insert, update on table public.reasoning_latest to anon, authenticated;

drop policy if exists "anyone can read" on public.reasoning_latest;
create policy "anyone can read" on public.reasoning_latest
  for select using (true);

drop policy if exists "anyone can insert" on public.reasoning_latest;
create policy "anyone can insert" on public.reasoning_latest
  for insert with check (true);

drop policy if exists "anyone can update" on public.reasoning_latest;
create policy "anyone can update" on public.reasoning_latest
  for update using (true) with check (true);