angular.module 'flashSloth'

.service 'dialog', [
  '$q'
  '$mdDialog'
  '$mdMedia'
  (
    $q
    $mdDialog
    $mdMedia
  ) ->
    self = @

    parse_options = (options) ->
      if options.clickOutsideToClose is undefined
        options.clickOutsideToClose = true
      if options.hasBackdrop is undefined
        options.hasBackdrop = true
      if options.fullscreen = undefined
        options.fullscreen = Boolean($mdMedia('sm') or $mdMedia('xs'))
      options.focusOnOpen = Boolean(options.focusOnOpen)
      return options

    @promise = null

    @alert = ->
      $mdDialog.alert()

    @confirm = ->
      $mdDialog.confirm()

    @show = (options, force) ->
      if self.promise and not force
        self.cancel()
      else
        self.promise = $mdDialog.show(parse_options(options))

      return self.promise


    @hide = (data) ->
      $mdDialog.hide(data)

    @cancel = (data) ->
      $mdDialog.cancel(data)

    return @
]