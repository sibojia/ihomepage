<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
    <%@ page import="java.sql.*" %>
    <jsp:useBean id="data" scope="page" class="b.InfoB" />
    <jsp:useBean id="stb" scope="page" class="b.SubscribeToB" />
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>InfoHub</title>
    <link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.0/css/bootstrap-combined.min.css" rel="stylesheet">
    <style type='text/css'>
      body {
        background-color: #CCC;
      }
      
    </style>
      <script language="javascript" type="text/javascript">
 	</script>
</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<a class="brand" href="index.jsp">InfoHub</a>
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li class="active"><a href="index.jsp">��ҳ</a></li>
						<li><a href="subscribe.jsp">���ı���</a></li>
						
						<% if (request.getSession().getAttribute("username")==null) { %>
							<li><a href="notlogsummary.jsp">�ۺ�</a></li>
							<li><a href="notlogjiuijing.jsp">ϵ�ڹ���</a></li>
							<li><a href="notloginfo.jsp">Info����</a></li>
						<% } else {
							String uid=request.getSession().getAttribute("id").toString(); %>
							<li><a href="zonghe.jsp">�ۺ�</a></li>
							<% if (stb.isOrder(1,uid)) %> <li><a href="info.jsp">Info����</a></li>
							<% if (stb.isOrder(2,uid)) %> <li><a href="JiuJing.jsp">ϵ�ڹ���</a></li>
							
							<% if (stb.isOrder(4,uid)) %> <li><a href="renren.jsp">������Ϣ</a></li>
						<%} %>
					</ul>
					<% if (request.getSession().getAttribute("username") != null) out.write("<!--"); %>
					<form name="login" class="navbar-form pull-right" action="index.jsp?iAction=check" method="post" onsubmit="return checkEmpty();">
						<input class="span2" type="text" placeholder="Username" name="username">
						<input class="span2" type="password" placeholder="Password" name="password">
						<button type="submit" class="btn">��¼</button>
						<a button type="button" class="btn" href="reg.jsp">ע��</button></a>
					</form>		
					<% if (request.getSession().getAttribute("username") != null) out.write("-->"); %>
					<% if (request.getSession().getAttribute("username") == null) out.write("<!--"); %>
					<form class="navbar-form pull-right" action="index.jsp?iAction=logout" method="post">
						<span style="color: white;">
						<% if (request.getSession().getAttribute("username") != null)
							out.write("Hello!"+request.getSession().getAttribute("username").toString()+"  ");%>
						</span>
						<button type="submit" class="btn">�ǳ�</button>
					</form>
					<% if (request.getSession().getAttribute("username") == null) out.write("-->"); %>
				</div>
			</div>
		</div>
	</div>
	
	<%
		ResultSet rs = null;
		rs = data.getInfoData();
		%>
	
	<div class="container">
		<div class="hero-unit">
			<h2>Info����</h2>
			
			<form class="navbar-form" >
				<table id="tb" class="datatb" cellspacing="0" width="100%" rules=all border frame=box>
				 <tr>
				 <td width="90%" align=center>����</td><td width="10%" align=center>ʱ��</td>
				 </tr>
				<%
					while(rs.next())
					{				
						String cid=rs.getString("COMMENTID");
				%>
					<tr>
					<td ><a href=<%= rs.getString("LINK") %>><%= rs.getString("TITLE") %></a></td>
					<td><%= rs.getString("WHEN") %></td>
					</tr>
				<%
					}
				%>
					
				</table>
			</form>
			
			<br> </br>
		</div>

		<hr>

		<footer>
			<p>&copy; null, Dept. CST, Tsinghua Univ., 2013</p>
		</footer>

	</div>
	
</body>
</html>