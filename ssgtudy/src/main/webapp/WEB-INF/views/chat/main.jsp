<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">

.chat-msg-container {
	display: flex;
	flex-direction:column; 
	height: 310px;
	overflow-y: scroll;
}

.chat-connection-list {
	height: 355px;
	overflow-y: scroll;
}
.chat-connection-list span {
	display: block;
	cursor: pointer;
	margin-bottom: 3px;
}
.chat-connection-list span:hover {
	color: #0d6efd
}

.user-left {
	color: #0d6efd;
	font-weight: 700;
	font-size: 10px;
	margin-left: 3px;
	margin-bottom: 1px;
}

.chat-info, .msg-left, .msg-right {
	max-width: 350px;
	line-height: 1.5;
	font-size: 13px;
    padding: 0.35em 0.65em;
    border: 1px solid #ccc;
    color: #333;
    white-space: pre-wrap;
    vertical-align: baseline;
    border-radius: 0.25rem;
}
.chat-info {
    background: #f8f9fa;
    color: #333;
    margin-right: auto;
    margin-left: 3px;
    margin-bottom: 5px;
}
.msg-left {
    margin-right: auto;
    margin-left: 8px;
    margin-bottom: 5px;
}
.msg-right {
	margin-left: auto;
    margin-right: 3px;
    margin-bottom: 5px;
}
</style>

<section class="row">
	<div class="card">
		<br>
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h3><i class="bi bi-chat"></i> 자유 채팅방 <br>
					<small class="form-control-plaintext" style="font-size:15px; font-weight:normal">바른 말, 고운 말로 대화 부탁드립니다.</small> </h3>
				</div>
				
				<div class="body-main content-frame">
					<div class="row">
						<div class="col-8">
							<p class="form-control-plaintext fs-6"><i class="bi bi-chevron-double-right"></i> 채팅 메시지</p>
							<div class="border p-3 chat-msg-container"></div>
							<div class="mt-2">
								<input type="text" id="chatMsg" class="form-control" 
									placeholder="채팅 메시지를 입력 하세요.">
							</div>
						</div>
						<div class="col-4">
							<p class="form-control-plaintext fs-6"><i class="bi bi-chevron-double-right"></i> 동시 접속자</p>
							<div class="border p-3 chat-connection-list"></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 귓속말 Modal -->
		<div class="modal fade" id="myDialogModal" tabindex="-1" aria-labelledby="myDialogModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="myDialogModalLabel">귓속말</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body pt-1">
						<input type="text" id="chatOneMsg" class="form-control" 
									placeholder="귓속말을 입력 하세요.">
					</div>
				</div>
			</div>
		</div>
		<br>
	</div>   
</section>

<script type="text/javascript">
$(function(){
	var socket = null;
	
	// - 채팅창을 실행할 때 다음과 같이 ip로 실행
	//   http://아이피주소:포트번호/cp/chat/main

	// - 채팅서버
	//   ws://ip주소:포트번호/cp/chat.msg
	var host="${wsURL}";
	// var host='wss://' + window.location.host + '/wchat.msg';  // https
	
	if ('WebSocket' in window) {
		socket = new WebSocket(host);
    } else if ('MozWebSocket' in window) {
    	socket = new MozWebSocket(host);
    } else {
    	writeToScreen("<div class='chat-info'>브라우저의 버전이 낮아 채팅이 불가능 합니다.</div>");
        return false;
    }

	socket.onopen = function(evt) { onOpen(evt) };
	socket.onclose = function(evt) { onClose(evt) };
	socket.onmessage = function(evt) { onMessage(evt) };
	socket.onerror = function(evt) { onError(evt) };
	
	 // 서버 접속이 성공한 경우 호출되는 콜백함수
	function onOpen(evt) {
		var uid = "${sessionScope.member.userId}";
		var nickName = "${sessionScope.member.nickName}";
		if(! uid) {
			location.href="${pageContext.request.contextPath}/member/login";
			return;
		}
		
		writeToScreen("<div class='msg-right'>채팅방에 입장했습니다. </div>");
		
		// 서버 접속이 성공하면 아이디와 이름을 JSON으로 서버에 전송
		var obj = {};
		var jsonStr;
		
		obj.cmd = "connect";
		obj.uid = uid;
		obj.nickName = nickName;
		jsonStr = JSON.stringify(obj); // stringify(obj) : 자바스크립트 객체를 json 형식의 문자열로 변환
		socket.send(jsonStr);	// 서버로 전송하기
		
		$("#chatMsg").on("keydown", function(event){
			// 엔터를 누를 경우 서버로 메시지를 전송한다.
			if(event.keyCode === 13) {
				sendMessage();
			}
		});	
	 }

	// 연결이 끊어진 경우에 호출되는 콜백함수
	function onClose(evt) {
		$("#chatMsg").on("keydown", null);
		writeToScreen("<div class='chat-info'>WebSocket closed.</div>");	
	}

	// 서버로부터 메시지를 받은 경우에 호출되는 콜백함수
	function onMessage(evt) {
		// 전송 받은 문자열을 JSON 객체로 변환
		var data = JSON.parse(evt.data);
		
		var cmd = data.cmd;
		
		if(cmd === "connectList") {	// 최초 접속한 사람들 리스트
			var uid = data.uid;
			var nickName = data.nickName;
			
			var out = "<span id='user-"+uid+"' data-uid='"+uid+"'><i class='bi bi-person-square'></i> "+nickName+"</span>";
			$(".chat-connection-list").append(out);
		} else if(cmd == "connect") {
			var uid = data.uid;
			var nickName = data.nickName;
			
			var out = "<div class='chat-info'>"+nickName+"님이 입장했습니다.</div>";
			writeToScreen(out);
			
			out = "<span id='user-"+uid+"' data-uid='"+uid+"'><i class='bi bi-person-square'></i> "+nickName+"</span>";
			$(".chat-connection-list").append(out);
		} else if(cmd === "disconnect") {
			var uid = data.uid;
			var nickName = data.nickName;
			var out = "<div class='chat-info'>"+nickName+"님이 나갔습니다.</div>";
			writeToScreen(out);
			
			$("#user-"+uid).remove();
		} else if(cmd === "message") {
			// 메시지를 받은 경우
			var uid = data.uid;
			var nickName = data.nickName;
			var msg = data.chatMsg;
			
			var out = "<div class='user-left'>"+nickName+"</div>";
			out += "<div class='msg-left'>"+msg+"</div>";
			
			writeToScreen(out);
		} else if(cmd == "whisper") {
			// 귓속말을 받은 경우
			var uid = data.uid;
			var nickName = data.nickName;
			var msg = data.chatMsg;
			
			var out = "<div class='user-left'>"+nickName+"(귓속말)</div>";
			out += "<div class='msg-left'>"+msg+"</div>";
			
			writeToScreen(out);
		} else if(cmd === "time") {
			var h = data.hour;
			var m = data.minute;
			var s = data.second;
			
			console.log(h+":"+m+":"+s);
		}
	}

	// 에러가 발생시 호출되는 콜백함수
	function onError(evt) {

	}
	
	// 채팅 메시지 전송
	function sendMessage() {
		var msg = $("#chatMsg").val().trim();
		if(! msg) {
			$("#chatMsg").focus();
			return;
		}
		
		var job = {};
		var jsonStr;
		job.cmd = "message";
		job.chatMsg = msg;
		jsonStr = JSON.stringify(job);
		socket.send(jsonStr);
		
		$("#chatMsg").val("");
		writeToScreen("<div class='msg-right'>"+msg+"</div>");
		
	}
	
	// -----------------------------------------
	// 채팅 참여자 리스트를 클릭한 경우 위스퍼(귓속말, dm) 대화상자 열기
	$("body").on("click", ".chat-connection-list span", function(){
		var uid = $(this).attr("data-uid");
		var nickName = $(this).text();
		
		$("#chatOneMsg").attr("data-uid", uid);
		$("#chatOneMsg").attr("data-nickName", nickName);
		
		var myModalEl = document.getElementById('myDialogModal');
		myModalEl.addEventListener('show.bs.modal', function(event) {
			$("#chatOneMsg").on("keydown", function(event){
				if(event.keyCode == 13) {
					sendOneMessage();
				}
			});
		});
		
		myModalEl.addEventListener('hidden.bs.modal', function(event) {
			$("#chatOneMsg").on("keydown", null);
			$("#chatOneMsg").val("");
		});
		
		$("#myDialogModalLabel").html("귓속말-"+nickName);
		$("#myDialogModal").modal("show");
		
	});
	
	// -----------------------------------------
	// 귓속말 전송
	function sendOneMessage() {
		var msg = $("#chatOneMsg").val().trim();
		if(! msg) {
			$("#chatOneMsg").focus();
			return false;
		}
		
		var uid = $("#chatOneMsg").attr("data-uid");
		var nickName = $("#chatOneMsg").attr("data-nickName").trim();
		
		var obj = {};
		var jsonStr;
		obj.cmd = "whisper";
		obj.chatMsg = msg;
		obj.receiver = uid;
		jsonStr = JSON.stringify(obj);
		socket.send(jsonStr);
		
		writeToScreen("<div class='msg-right'>"+msg+"("+nickName+")</div>");
		
		$("#chatOneMsg").val("");
		$("#myDialogModal").modal("hide");
	}
	
});

//---------------------------------------------
// 채팅 메시지를 출력하기 위한 함수
function writeToScreen(message) {
	var $obj = $(".chat-msg-container");
	$obj.append(message);
	
	$obj.scrollTop($obj.prop("scrollHeight"));
	
}
</script>