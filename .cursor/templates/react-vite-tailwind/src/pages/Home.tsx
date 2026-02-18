import Section from "../components/Section";

const metrics = [
  { label: "Conversas", value: "12.4k", delta: "+12%" },
  { label: "Tempo medio", value: "3m 20s", delta: "-4%" },
  { label: "Satisfacao", value: "92%", delta: "+3%" }
];

export default function Home() {
  return (
    <main className="min-h-screen bg-slate-950 text-slate-100">
      <div className="mx-auto flex w-full max-w-5xl flex-col gap-8 px-6 py-10">
        <header className="space-y-2">
          <p className="text-xs uppercase tracking-[0.24em] text-slate-400">
            Dashboard operacional
          </p>
          <h1 className="text-3xl font-semibold">Visao geral</h1>
          <p className="max-w-2xl text-sm text-slate-300">
            Estrutura simples para iniciar um projeto com regras de
            governanca e qualidade.
          </p>
        </header>

        <Section title="Indicadores principais">
          <div className="grid gap-4 md:grid-cols-3">
            {metrics.map(metric => (
              <div
                key={metric.label}
                className="rounded-xl border border-slate-800 bg-slate-900/60 p-4"
              >
                <p className="text-xs text-slate-400">{metric.label}</p>
                <div className="mt-2 flex items-baseline justify-between">
                  <span className="text-2xl font-semibold">{metric.value}</span>
                  <span className="text-xs text-emerald-400">
                    {metric.delta}
                  </span>
                </div>
              </div>
            ))}
          </div>
        </Section>

        <Section title="Proximas acoes">
          <ul className="space-y-3 text-sm text-slate-300">
            <li>Atualizar o report diario e rodar os gates.</li>
            <li>Validar requisitos antes de iniciar uma nova feature.</li>
            <li>Manter padroes aprovados de layout e tipografia.</li>
          </ul>
        </Section>
      </div>
    </main>
  );
}
