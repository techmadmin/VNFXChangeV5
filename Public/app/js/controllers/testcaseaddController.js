routerApp.controller('testcaseaddController',['$scope', '$sce','$http',function(scope,sce,http)
{
	scope.tpath ='testcasesad.html';
    scope.tcvnftype='';
	scope.tcdes='';
	scope.gotofun=function(tpath){
		console.log("tpath---------------"+ tpath)
		scope.isDisabled = false;
		scope.tpath=tpath;

scope.viewDisplay = false;		
	}
	
	
	scope.tcontypeChange=function(selectedtcType){
		scope.tcvnftype=selectedtcType;
		
	}
	scope.ontcdeschange=function(createtcDesc){
		scope.tcdes=createtcDesc;
		console.log("tcvnf"+scope.tcdes)
	}
	scope.addtc=function(tcname){
		var tcvnfname=scope.tcvnftype;
		var tcdesc=scope.tcdes;
		var testname=tcname;
		scope.searchButtonText="Searching";
		
		var today = new Date();
	    var dd = today.getDate();
	    var mm = today.getMonth()+1;
	    var yyyy = today.getFullYear();
	    if(dd<10){
        dd='0'+dd;
	    } 
	    if(mm<10){
		mm='0'+mm;
	    } 
	    var today = dd+'/'+mm+'/'+yyyy;
		console.log("eedate"+today);
		scope.exedate=today;
		console.log("eedate"+scope.exedate);
		
		http({
			url:"http://10.53.172.9:8080/vnftestcaseadd",
			method:"POST",
			params:{tcadd_date:today,tcvnfnam:tcvnfname,tcnam:testname,tcdesn:tcdesc}
			}).then(function (response){
				var odata=JSON.stringify(response.data);
				
			});
			
			setTimeout(function () {
		    scope.$apply(function(){
			scope.searchButtonText="false";
			scope.onboardFileSuccess = true;
			          
		  });
		}, 3000);
			
		
	}
	
}]);