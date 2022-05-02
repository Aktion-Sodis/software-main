const charts = {
    state: () => ({
        graphData: {
            data: [
                {
                    x: ['Apples', 'Oranges', 'Watermelon', 'Pears'],
                    y: [3, 2, 1, 4],
                    type: 'bar'
                }
            ],
            layout: {
                yaxis: {
                    title: 'Y-axis Title',
                    ticktext: ['long label', 'Very long label', '3', 'label'],
                    tickvals: [1, 2, 3, 4],
                    tickmode: 'array',
                    automargin: true,
                    titlefont: { size: 30 },
                },
                paper_bgcolor: '#7f7f7f',
                plot_bgcolor: '#c7c7c7'
            },
            config: { responsive: true }
        },
    }),
}

export default charts;