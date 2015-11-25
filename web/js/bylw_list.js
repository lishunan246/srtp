/**
 * Created by Shunan on 2015/11/25.
 */
angular.module('App')
    .controller('bylwListController', function($scope,$http,$uibModal) {
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

        $scope.openZhidao=function(id){
            var modal=$uibModal.open({
                templateUrl:'BYLWzhidao.html',
                controller:'BYLWzhidaoCtrl',
                resolve:{
                    id:function(){
                        return id;
                    }
                }
            });
        };
    });

angular.module('App').controller('BYLWzhidaoCtrl',function($scope, $uibModalInstance,id,$http){
    $scope.id=parseInt(id);

    $scope.getZhidao=function(){
        $http.post('/bylwzhidaoquery.do',{'saccount':$scope.id}).success(function(msg){
            console.log(msg);
            if(!msg.status){
                alert(msg.message);
            }
            else {
                $scope.grade=msg.ds_grade;
                $scope.pass=msg.supervisorpass;
                $scope.comment=msg.supervisorcomment;
            }
        })
    };

    $scope.okBYLWzhidao = function () {
        $http.post('/bylwzhidaosubmit.do',{
            saccount:$scope.id,
            comment:$scope.comment,
            pass:$scope.pass,
            grade:$scope.grade
        }).success(function(msg){
            if(!msg.status){
                alert(msg.message);
            }
            else {
                alert('修改成功');
            }
            $scope.getZhidao();
        });
    };

    $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
    };

    $scope.getZhidao();
});