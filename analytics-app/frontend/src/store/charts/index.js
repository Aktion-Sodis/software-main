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
                title: {
                    text: 'Plot Title',
                    font: {
                        size: 24
                    },
                    xref: 'paper',
                },
                yaxis: {
                    title: 'Y-axis Title',
                    tickvals: [1, 2, 3, 4],
                    tickmode: 'array',
                    automargin: true,
                    titlefont: { size: 20 },
                },
                xaxis: {
                    title: 'X-axis Title',
                    automargin: true,
                    titlefont: { size: 20 },
                },
                paper_bgcolor: '#rgb(45, 145, 190, 0.2)',
                plot_bgcolor: '#rgb(45, 145, 190, 0.2)',
            },
            config: { responsive: true }
        },
    }),
}

export default charts;