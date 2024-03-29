console.log("Reply Module.......");

var replyService = (function(){

	//return {name:"AAAA"};

	/*
	function add(reply, callback) {
		console.log("Reply.......");
	}
	
	return {add:add};
	*/
	
	
	function add(reply, callback, error) {
		console.log("add Reply.......");
		
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function (result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
		});	
	}
		
	function getList(param, callback, error) {
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json", 
			function(data) {
				if(callback){
					callback(data);
				}
			}).fail(function(xhr, status, err) {
				if(error){
					error();
				}
			});
	}
	
	function remove(rno, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			success : function (deleteResult, status, xhr) {
				if(callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
		});
	}
	
	function modify(reply, callback, error) {
		console.log("RNO : " + reply.rno);
		
		$.ajax({
			type : 'put',
			url : '/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function (result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
		});	
	}
	
	function get(rno, callback, error) {

		$.getJSON("/replies/" + rno + ".json", 
			function(result) {
				if(callback){
					callback(result);
				}
			}).fail(function(xhr, status, err) {
				if(error){
					error();
				}
			});
	}
	
	
	function displayTime(timeValue){
		var today = new Date();
		
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str = "";
		
			//차이가 24시간 보다 적게 나면 시/분/초 로 표시
			if(gap < (1000 * 60 * 60 * 24)) {
				var hh = dateObj.getHours();
				var mi = dateObj.getMinutes();
				var ss = dateObj.getSeconds();
				
				return [(hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss].join('');
			}
			else {
				var yy = dateObj.getFullYear();
				var mm = dateObj.getMonth() + 1; //getMonth는 0부터 시작하기 때문
				var dd = dateObj.getDate();
								return [yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd].join('');
			}
	};
	
	function getList(param, callback, error) {
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
			function(data) {
				if(callback) {
					//callback(data); //댓글 목록만 가져오는 경우
					callback(data.replyCnt, data.list); //댓글 개수와 목록을 가져오는 경우
				}
			}).fail(function(xhr, status, err) {
				if(error) {
					error();
				}
			});
	}
	
	return {
		add:add,
		getList : getList,
		remove : remove,
		modify : modify,
		get : get,
		displayTime : displayTime
	};
	
})();