app = angular.module('dealershipApp', ['restangular', 'ngAnimate'])

app.config(['$animateProvider', ($animateProvider)->
  $animateProvider.classNameFilter(/do-animate/)
])