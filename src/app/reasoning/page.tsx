import { loadLatest } from "@/lib/reasoning-store";

export const metadata = { title: "Reasoning & Uncertainty" };

export default async function ReasoningPage() {
  const latest = await loadLatest();
  const syllogism = latest.syllogism?.answer;
  const plausibility = latest.plausibility?.answer;
  const bernoulli = latest.bernoulli?.answer;

  return (
    <main className="mx-auto max-w-4xl px-6 py-14">
      <p className="text-sm font-semibold uppercase tracking-[0.2em] text-accent">
        Lane 2 · live answers
      </p>
      <h1 className="mt-3 text-4xl font-bold">Reasoning &amp; Uncertainty</h1>
      <p className="mt-5 max-w-prose text-lg text-muted">
        The latest answers from the reasoning service, saved in Supabase.
      </p>
      <section className="mt-10 grid gap-5 md:grid-cols-3">
        <article className="rounded-xl border border-line bg-surface p-5">
          <h2 className="text-xl font-semibold">Syllogism</h2>
          <p className="mt-4 text-muted">Verdict</p>
          <p data-reasoning="verdict" className="mt-1 text-2xl font-bold">
            {syllogism?.verdict ?? "No probe yet"}
          </p>
        </article>
        <article className="rounded-xl border border-line bg-surface p-5">
          <h2 className="text-xl font-semibold">Plausibility</h2>
          <p className="mt-4 text-muted">Posterior</p>
          <p data-reasoning="posterior" className="mt-1 text-2xl font-bold">
            {typeof plausibility?.posterior === "number"
              ? plausibility.posterior.toFixed(3)
              : "No probe yet"}
          </p>
        </article>
        <article className="rounded-xl border border-line bg-surface p-5">
          <h2 className="text-xl font-semibold">Bernoulli</h2>
          <p className="mt-4 text-muted">Expected value</p>
          <p data-reasoning="expected-value" className="mt-1 text-2xl font-bold">
            {typeof bernoulli?.expectedValue === "number"
              ? bernoulli.expectedValue.toFixed(2)
              : "No probe yet"}
          </p>
        </article>
      </section>
    </main>
  );
}
