<%--
  Created by IntelliJ IDEA.
  User: Shunan
  Date: 2015/11/27
  Time: 12:49
  To change this template use File | Settings | File Templates.
--%>
<%@include file="header.jsp" %>
<%@include file="navbar.jsp" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!-- Begin page content -->

<script>
    /**
     * Created by Shunan on 2015/11/25.
     */
    angular.module('App')
            .controller('ktbgListController', function($scope,$http,$uibModal) {
                $scope.m=[];
                $scope.z=[];

                $scope.getdaoshi=function(){
                    $http.post("/ktbgzhidaolist.do").success(function(msg){
                        $scope.z= msg.count>0?msg.student:[];
                        console.log($scope.z);
                    });
                };

                $scope.getmangdao=function(){
                    $http.post("/ktbgmangdaolist.do").success(function(msg){
                        $scope.m= msg.count>0?msg.student:[];
                        console.log($scope.m);
                    });

                };

                $scope.getdaoshi();
                $scope.getmangdao();

                $scope.openZhidao=function(id){
                    var modal=$uibModal.open({
                        templateUrl:'KTBGzhidao.html',
                        controller:'KTBGzhidaoCtrl',
                        resolve:{
                            id:function(){
                                return id;
                            }
                        }
                    });
                };
                $scope.openMangdao=function(id){
                    var modal=$uibModal.open({
                        templateUrl:'KTBGmangdao.html',
                        controller:'KTBGmangdaoCtrl',
                        resolve:{
                            id:function(){
                                return id;
                            }
                        }
                    });
                };
            });

    angular.module('App').controller('KTBGzhidaoCtrl',function($scope, $uibModalInstance,id,$http){
        $scope.id=parseInt(id);

        $scope.getZhidao=function(){
            $http({
                method: 'POST',
                url: '/ktbgzhidaoquery.do',
                data: $.param({'saccount':$scope.id}),
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            }).success(function(msg){
                console.log(msg);
                if(!msg.status){
                    alert(msg.message);
                }
                else {
                    $scope.grade=parseInt(msg.ds_grade);
                    $scope.pass=(msg.ds_pass == "1");
                    $scope.comment=msg.ds_comment;
                    $scope.chineseName=msg.name_cn;
                    $scope.englishName=msg.name_en;
                    $scope.description=msg.description;
                    $scope.type=(msg.type=='lw')?"毕业论文":"毕业设计";
                }
            })
        };

        $scope.okKTBGzhidao = function () {
            $http({
                method: 'POST',
                url: '/ktbgzhidaosubmit.do',
                data: $.param({
                    saccount:$scope.id,
                    comment:$scope.comment,
                    pass:$scope.pass,
                    grade:parseInt( $scope.grade)
                }),
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
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

    angular.module('App').controller('KTBGmangdaoCtrl',function($scope, $uibModalInstance,id,$http){
        $scope.id=parseInt(id);

        $scope.getMangdao=function(){
            $http({
                method: 'POST',
                url: '/ktbgmangdaoquery.do',
                data: $.param({'saccount':$scope.id}),
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            }).success(function(msg){
                console.log(msg);
                if(!msg.status){
                    alert(msg.message);
                }
                else {
                    $scope.grade= parseInt(msg.md_grade);
                    $scope.pass=(msg.md_pass=="1");
                    $scope.comment=msg.md_comment;
                    $scope.chineseName=msg.name_cn;
                    $scope.englishName=msg.name_en;
                    $scope.description=msg.description;
                    $scope.type=(msg.type=='lw')?"毕业论文":"毕业设计";
                }
            })
        };

        $scope.okKTBGmangdao = function () {
            $http({
                method: 'POST',
                url: '/ktbgmangdaosubmit.do',
                data: $.param({
                    saccount:$scope.id,
                    comment:$scope.comment,
                    pass:$scope.pass,
                    grade:$scope.grade
                }),
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            }).success(function(msg){
                if(!msg.status){
                    alert(msg.message);
                }
                else {
                    alert('修改成功');
                }
                $scope.getMangdao();
            });
        };

        $scope.cancel = function () {
            $uibModalInstance.dismiss('cancel');
        };

        $scope.getMangdao();
    });
</script>


<div class="row">
    <div class="col-md-3 col-md-offset-1">
        <%@include file="teacher_panels.jsp" %>
    </div>
    <script type="text/ng-template" id="KTBGzhidao.html">
        <div class="modal-header">
            <h3 class="modal-title">评估开题报告</h3>
        </div>
        <div class="modal-body">
            <div>
                <dl>
                    <dt>英文名</dt>
                    <dd >{{englishName}}</dd>

                    <dt>中文名</dt>
                    <dd >{{chineseName}}</dd>
                    <dt>类型</dt>
                    <dd >{{type}}</dd>
                    <dt>描述</dt>
                    <dd>{{description}}</dd>
                </dl>
            </div>
            <form style="position: relative;top:-20px;" method="post" action="ktbgdownload.do">
                <input  class="hidden" type="text" name="saccount" ng-model="id"/><br/>
                <button class="btn btn-default" type="submit" value="下载开题报告">下载文件</button>
            </form>

            <form>
                <div class="form-group">
                    <label for="grade">分数</label>
                    <input type="number"  ng-model="grade">
                </div>
                <div class="form-group">
                    <label for="comment">评论</label>
                    <input type="text"  ng-model="comment">
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" ng-model="pass"> 予以通过
                    </label>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn btn-primary" type="button" ng-click="okKTBGzhidao()">提交</button>
            <button class="btn btn-warning" type="button" ng-click="cancel()">关闭</button>
        </div>
    </script>
    <script type="text/ng-template" id="KTBGmangdao.html">
        <div class="modal-header">
            <h3 class="modal-title">评估毕业论文(盲审)</h3>

        </div>
        <div class="modal-body">
            <div>
                <dl>
                    <dt>英文名</dt>
                    <dd id="name_en_ktbg">{{englishName}}</dd>

                    <dt>中文名</dt>
                    <dd id="name_cn_ktbg">{{chineseName}}</dd>
                    <dt>类型</dt>
                    <dd id="type_ktbg">{{type}}</dd>
                    <dt>描述</dt>
                    <dd id="description_ktbg">{{description}}</dd>
                </dl>
            </div>
            <form style="position: relative;top:-20px;" method="post" action="ktbgdownload.do">
                <input  class="hidden" type="text" name="saccount" ng-model="id"/><br/>
                <button class="btn btn-default" type="submit" value="下载开题报告">下载文件</button>
            </form>
            <form>
                <div class="form-group">
                    <label for="grade">分数</label>
                    <input type="number" id="grade" ng-model="grade">
                </div>
                <div class="form-group">
                    <label for="comment">评论</label>
                    <input type="text" id="comment" ng-model="comment">
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" ng-model="pass"> 予以通过
                    </label>
                </div>
            </form>
        </div>
        <div class="modal-footer">

            <button class="btn btn-primary" type="button" ng-click="okKTBGmangdao()">提交</button>
            <button class="btn btn-warning" type="button" ng-click="cancel()">关闭</button>
        </div>
    </script>
    <div ng-controller="ktbgListController" class="col-md-7">
        <div class="container" id="right-part">
            <table class="table table-hover table-bordered">
                <tr class="info">
                    <td>学号</td>
                    <td>姓名</td>
                    <td>是否通过</td>
                    <td>类型</td>
                </tr>
                <tr ng-repeat="x in z" ng-click="openZhidao(x.sid)">
                    <td>{{x.sid}}</td>
                    <td>{{x.sname}}</td>
                    <td>{{x.supervisorpass=="1"?"是":"否"}}</td>
                    <td>指导</td>
                </tr>
            </table>

            <table class="table table-hover table-bordered">
                <tr class="info">
                    <td>学号</td>
                    <td>姓名</td>
                    <td>是否通过</td>
                    <td>类型</td>
                </tr>
                <tr ng-repeat="x in m" ng-click="openMangdao(x.sid)">
                    <td>{{x.sid}}</td>
                    <td>{{x.sname}}</td>
                    <td>{{x.anonymouspass=="1"?"是":"否"}}</td>
                    <td>盲审</td>
                </tr>
            </table>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>

