<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kh.member.model.vo.Member,java.util.ArrayList, com.kh.qna.model.vo.QNA, com.kh.board.model.vo.*" %>
<%
	Member mem = (Member)request.getAttribute("mem");
	ArrayList<QNA> list = (ArrayList<QNA>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	
	int listCount = pi.getListCount();
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>My Page</title>

  <!-- Bootstrap core CSS -->
  <link href="<%= request.getContextPath() %>/resources/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="<%= request.getContextPath() %>/resources/css/modern-business.css" rel="stylesheet">

  <style>
    tr {text-align: center;}
    #cNum{width: 40px;}
    #date{width: 110px;}
    #title{width: 450px;}
    #status{width: 80px;}
    .listArea>tbody>tr:hover{
      cursor: pointer;
      background: skyblue;
    }
    p.content{
      border: 1px solid lightgray;
      width: 300px;
      height: 100px;
      margin-top: 5px;
      display: none;
     }
  </style>
</head>

<body>

  <!-- Navigation -->
  <%@ include file="../common/menubar.jsp" %>

  <!-- Page Content -->
  <div class="container">

    <!-- Page Heading/Breadcrumbs -->
    <h1 class="mt-4 mb-3">마이페이지</h1>

    <ol class="breadcrumb">
      <li class="breadcrumb-item">
        <a href="index.html">메인</a>
      </li>
      <li class="breadcrumb-item active">마이페이지</li>
    </ol>

    <!-- Content Row -->
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-lg-3 mb-4">
        <%@ include file="myPageSidebar.jsp" %>
      </div>
      <!-- Content Column -->
      <div class="col-lg-9 mb-4">
        <h2 align="center">문의글 확인</h2>
        <hr>
        <table class="listArea" border="1" align="center">
          <thead>
            <tr>
              <th id="cNum">순번</th>
              <th id="date">날짜</th>
              <th id="title">제목</th>
              <th id="status">처리상태</th>
            </tr>
          </thead>
          <tbody>
          	<% if(list.isEmpty()) { %>
          	  <tr>
          	    <td colspan="4"><h1>조회된 리스트가 없습니다.</h1></td>
          	  </tr>
          	<% } else { %>
          	  <% for(QNA q : list) { %>
          	  <% String state = ""; %>
          	    <% if(q.getQnaAnswerState().equals("N")) { %>
          	      <% state = "접수"; %>
          	    <% } else { %>
          	      <% state = "답변"; %>
          	    <% } %>
          	    <tr>
          	      <td><%= q.getListNo() %></td>
          	      <td><%= q.getQnaDate() %></td>
          	      <td><%= q.getQnaTitle() %></td>
          	      <td><%= state %></td>
          	    </tr>
          	  <% } %>
          	<% } %>
            <!-- <div>
              <tr>
                <td>5</td>
                <td>2020-02-10</td>
                <td>아무거나 5화</td>
                <td>접수</td>
              </tr>
            </div>
            <div>
              <tr>
                <td>4</td>
                <td>2020-02-05</td>
                <td>아무거나 4화</td>
                <td>답변</td>
              </tr>
            </div>
            <p class="content">testtesttest</p>
            <tr>
              <td>3</td>
              <td>2020-01-01</td>
              <td>아무거나 3화</td>
              <td>답변</td>
            </tr>
            <tr>
              <td>2</td>
              <td>2019-12-31</td>
              <td>아무거나 2화</td>
              <td>답변</td>
            </tr>
            <tr>
              <td>1</td>
              <td>2019-12-23</td>
              <td>아무거나 1화</td>
              <td>답변</td>
            </tr> -->
          </tbody>
        </table>
        <!-- 페이징바 영역 -->
		<div class="pagingArea" align="center">
			<!-- 맨 처음으로 (<<) -->
			<button onclick="location.href='<%=contextPath%>/list.bo';"> &lt;&lt; </button>
			
			<!-- 이전페이지(<) -->
			<%if(currentPage == 1){ %>
			<button disabled> &lt; </button>
			<%}else{ %>
			<button onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=currentPage-1%>';"> &lt; </button>
			<%} %>
			
			<!-- 페이지 목록 -->
			<%for(int p=startPage; p<=endPage; p++){ %>
				
				<%if(currentPage == p){ %>
				<button disabled> <%=p%> </button>
				<%}else{ %>
				<button onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=p%>';"> <%= p %> </button>
				<%} %>
			
				
			<%} %>
			
			<!-- 다음페이지(>) -->
			<%if(currentPage == maxPage){ %>
			<button disabled> &gt; </button>
			<%}else{ %>
			<button onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=currentPage+1%>';"> &gt; </button>
			<%} %>
			
			
			<!-- 맨 마지막으로 (>>) -->
			<button onclick="location.href='<%=contextPath%>/list.bo?currentPage=<%=maxPage%>'"> &gt;&gt; </button>
		</div>
      </div>
    </div>
    <!-- /.row -->

    <script>
      jQuery.fn.prepareTableRowForSliding = function() {
        $tr = this;
        $tr.children('td').wrapInner('<div style="display: none;" />');
        return $tr;
      };

      jQuery.fn.slideFadeTableRow = function(speed, easing, callback) {
        $tr = this;
        if ($tr.is(':hidden')) {
        $tr.show().find('td > div').animate({opacity: 'toggle', height: 'toggle'}, speed, easing, callback);
        }  
    
        return $tr;
      };
    </script>

  </div>
  <!-- /.container -->

  <!-- Footer -->
  <footer class="py-5 bg-dark">
    <div class="container">
      <p class="m-0 text-center text-white">Copyright &copy; Your Website 2019</p>
    </div>
    <!-- /.container -->
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script src="<%= request.getContextPath() %>/resources/js/jquery.min.js"></script>
  <script src="<%= request.getContextPath() %>/resources/js/bootstrap.bundle.min.js"></script>

</body>

</html>