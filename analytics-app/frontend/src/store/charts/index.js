const charts = {
    state: () => ({
        graphData: {
            data: [
                {
                    x: ["giraffes", "orangutans", "monkeys"],
                    y: [20, 14, 23],
                    type: "bar",
                },
            ],
            layout: { title: "My graph" },
        },
    }),
}

export default charts;