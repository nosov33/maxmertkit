app = angular.module 'docsApp', [
	'ngRoute'
	'hljs'
]

paths =
	tmpl: '/templates'


# SubMenu creating
app.directive 'menu', ->
	templateUrl: "#{paths.tmpl}/common/menu.html"
	link: ( scope ) ->
		scope.items = [
			{
				name: 'main',
				link: '/main'
			},
			{
				name: 'widgets',
				link: '/widgets'
			},
			{
				name: 'components',
				link: '/components'
			}
		]


# SubMenu MAIN creating
app.directive 'submenu', ->
	templateUrl: "#{paths.tmpl}/common/submenu.html"
	link: ( scope, element, attrs ) ->
		scope.items = window[attrs.submenu]

		scope.$watch "partials", (value) ->
			$('[submenu="widgets"]').affix()


app.directive 'partials', ->
	templateUrl: "#{paths.tmpl}/common/partials.html"
	scope: {}
	link: ( scope, element, attrs ) ->
		scope.items = []
		
		for item in window[attrs.partials]
			scope.items.push
				name: item.name
				path: "#{paths.tmpl}/widgets/#{item.path}.html"
			if item.include?
				for subitem in item.include
					scope.items.push
						name: subitem.name
						path: "#{paths.tmpl}/widgets/#{subitem.path}.html"



app.directive "modal", ->
	(scope, element, attrs) ->
		scope.$watch "partials", (value) ->
			$('.btn-modal-fast').modal()
			$('.btn-modal123').modal
				beforeopen: ->
					d = $.Deferred()

					setTimeout ->
						d.resolve()
					, 2000

					d.promise()
				# onopen: ->
				# 	$('#main-content').addClass '-blur-- -start--'
				
				# onclose: ->
				# 	$('#main-content').removeClass '-blur-- -start--'
				#  

app.directive "popup", ->
	(scope, element, attrs) ->
		scope.$watch "partials", (value) ->
			$('.btn-popup-demo').popup
				beforeopen: ->
					popup = @data('kit-popup')
					content = popup.$el.find '.-content'
					content.html "Popup #{popup._id} with dynamic content<br>Random number #{Math.random()}"

				onopen: ->
					@addClass '_active_'

				onclose: ->
					@removeClass '_active_'

			$('.btn-popup-demo-bottom').popup
				positionVertical: 'bottom'
				beforeopen: ->
					popup = @data('kit-popup')
					content = popup.$el.find '.-content'
					content.html "Popup #{popup._id} with dynamic content<br>Random number #{Math.random()}"

				onopen: ->
					@addClass '_active_'

				onclose: ->
					@removeClass '_active_'

			$('.btn-popup-demo-left').popup
				positionVertical: 'middle'
				positionHorizontal: 'left'
				beforeopen: ->
					popup = @data('kit-popup')
					content = popup.$el.find '.-content'
					content.html "Popup #{popup._id} with dynamic content<br>Random number #{Math.random()}"

				onopen: ->
					@addClass '_active_'

				onclose: ->
					@removeClass '_active_'

			$('.btn-popup-demo-right').popup
				positionVertical: 'middle'
				positionHorizontal: 'right'
				beforeopen: ->
					popup = @data('kit-popup')
					content = popup.$el.find '.-content'
					content.html "Popup #{popup._id} with dynamic content<br>Random number #{Math.random()}"

				onopen: ->
					@addClass '_active_'

				onclose: ->
					@removeClass '_active_'

			$('.btn-popup-demo-bottom-right').popup
				positionVertical: 'bottom'
				positionHorizontal: 'right'
				beforeopen: ->
					popup = @data('kit-popup')
					content = popup.$el.find '.-content'
					content.html "Popup #{popup._id} with dynamic content<br>Random number #{Math.random()}"

				onopen: ->
					@addClass '_active_'

				onclose: ->
					@removeClass '_active_'

			$('.btn-popup-demo-top-left').popup
				positionVertical: 'top'
				positionHorizontal: 'left'
				beforeopen: ->
					popup = @data('kit-popup')
					content = popup.$el.find '.-content'
					content.html "Popup #{popup._id} with dynamic content<br>Random number #{Math.random()}"

				onopen: ->
					@addClass '_active_'

				onclose: ->
					@removeClass '_active_'




# APP CONFIGURATION
app.config ($routeProvider, $locationProvider) ->

	# Init Route provider
	$routeProvider
		.when '/main',
			templateUrl: "#{paths.tmpl}/main.html"

		.when '/widgets',
			templateUrl: "#{paths.tmpl}/widgets.html"

		.when '/components',
			templateUrl: "#{paths.tmpl}/components.html"

		.otherwise
			templateUrl: "#{paths.tmpl}/404.html"

	$locationProvider.html5Mode yes