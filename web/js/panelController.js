/**
    * Created by Shunan on 2015/11/25.
    * In srtp.
    */
var app=angular.module('App',['ui.bootstrap']);
angular.module('App').controller('panelController',function($scope,$uibModal){
    $scope.open=function(type){
        var modalInstance=$uibModal.open({
            animation:true,
            templateUrl:(type=='bylw')?'bylwuploadModal.html': 'uploadModal.html',
            controller:'ModalInstanceCtrl',
            resolve:{

            }
        })
    };
});

angular.module('App').controller('ModalInstanceCtrl',['$scope','fileUpload',function($scope,fileUpload,$uibModalInstance){
    $scope.uploadFile = function (uploadUrl) {
        var file = $scope.myFile;
        console.log('file is ');
        console.dir(file);

        fileUpload.uploadFileToUrl(file, uploadUrl);
        //$uibModalInstance.dismiss('cancel');
    };
}]);

app.directive('fileModel', ['$parse', function ($parse) {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            var model = $parse(attrs.fileModel);
            var modelSetter = model.assign;

            element.bind('change', function () {
                scope.$apply(function () {
                    modelSetter(scope, element[0].files[0]);
                });
            });
        }
    };
}]);

app.service('fileUpload', ['$http', function ($http) {
    this.uploadFileToUrl = function (file, uploadUrl) {
        var fd = new FormData();
        fd.append('file', file);
        $http.post(uploadUrl, fd, {
                transformRequest: angular.identity,
                headers: {
                    'Content-Type': undefined
                }
            })
            .success(function (data) {
                console.log(data);
                if(data.status)
                {
                    alert('上传成功');
                }
                else{
                    alert(data.message);
                }
            })
            .error(function (data) {
                console.log(data);
            });
    }
}]);