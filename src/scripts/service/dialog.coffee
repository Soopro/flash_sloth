angular.module 'flashSloth'

.service 'dialog', [
  '$q'
  '$mdDialog'
  (
    $q
    $mdDialog
  ) ->
    self = @

    parse_options = (options) ->
      if options.clickOutsideToClose is undefined
        options.clickOutsideToClose = true
      if options.hasBackdrop is undefined
        options.hasBackdrop = true
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
        self.promise.finally ->
          self.promise = null

      return self.promise


    @hide = (data) ->
      $mdDialog.hide(data)

    @cancel = (data) ->
      $mdDialog.cancel(data)

    return @
]