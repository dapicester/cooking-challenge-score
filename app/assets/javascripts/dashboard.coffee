# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  canvas = document.getElementById 'chart'
  data = document.getElementById 'chart-data'
  if canvas and data
    new Chart canvas,
      type: 'radar'
      data: JSON.parse(data.innerHTML)
      options:
        tooltips:
          callbacks:
            label: (item, data) ->
              dataset = data.datasets[item.datasetIndex]
              label = dataset.label
              value = dataset.data[item.index]
              maxValue = data.meta.maxValues[item.index]
              scaleFactor = data.meta.scaleFactors[item.index]
              scaled = value / scaleFactor
              "#{label}: #{scaled.toFixed 1} out of #{maxValue}" 
            labelColor: (item, chart) ->
              color = chart.config.data.datasets[item.datasetIndex].borderColor
              backgroundColor: color
        scale:
          ticks:
            display: false
            beginAtZero: true
            min: 0
            suggestedMax: 6 # TODO: get this from data
