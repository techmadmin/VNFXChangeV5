routerApp.controller('vnftestmanagementController',['$scope','$window',function(scope,window)
{
	
	
window.open(
  'http://localhost:8091/testlink/login.php',
  '_blank' // <- This is what makes it open in a new window.
 );
 console.log("openingg")	
 
 
 scope.searchButton ='searching';
 setTimeout(function () {
		    scope.$apply(function(){
			scope.searchButton="false";
			console.log("stoped----")
		    scope.onboardFileSuccess = true;	
             scope.viewDisplay = true;			
		  });
		}, 420000);
 
 
	
}]);