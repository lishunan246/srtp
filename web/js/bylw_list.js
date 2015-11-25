/**
 * Created by Shunan on 2015/11/25.
 */
angular.module('App')
    .controller('bylwListController', function($scope,$http) {
        $scope.m=[];
        $scope.z=[];

        $scope.getdaoshi=function(){
            $http.post("/bylwzhidaolist.do").success(function(msg){
                $scope.z= msg.count>0?msg.student:[];
                console.log($scope.z);
            });
        };

        $scope.getmangdao=function(){
            $http.post("/bylwmangdaolist.do").success(function(msg){
                $scope.m= msg.count>0?msg.student:[];
                console.log($scope.m);
            });

        };

        $scope.getdaoshi();
        $scope.getmangdao();



    });