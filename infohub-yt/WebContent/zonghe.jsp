<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="rrapi.*" 	 %>
    <%@ page import="com.renren.api.*" 	 %>
    <jsp:useBean id="datainfo" scope="page" class="b.InfoB" />
    <jsp:useBean id="datajiujing" scope="page" class="b.JiuJingB" />
    <jsp:useBean id="datarenren" scope="page" class="b.RenrenB" />
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
						<li class="active"><a href="index.jsp">主页</a></li>
						<li><a href="subscribe.jsp">订阅表单</a></li>
						
						<% if (request.getSession().getAttribute("username")==null) { %>
							<li><a href="notlogsummary.jsp">综合</a></li>
							<li><a href="notlogjiuijing.jsp">系内公告</a></li>
							<li><a href="notloginfo.jsp">Info公告</a></li>
						<% } else {
							String uid=request.getSession().getAttribute("id").toString(); %>
							<li><a href="zonghe.jsp">综合</a></li>
							<% if (stb.isOrder(1,uid)) %> <li><a href="info.jsp">Info公告</a></li>
							<% if (stb.isOrder(2,uid)) %> <li><a href="JiuJing.jsp">系内公告</a></li>
							
							<% if (stb.isOrder(4,uid)) %> <li><a href="renren.jsp">人人信息</a></li>
						<%} %>
					</ul>
					<% if (request.getSession().getAttribute("username") != null) out.write("<!--"); %>
					<form name="login" class="navbar-form pull-right" action="index.jsp?iAction=check" method="post" onsubmit="return checkEmpty();">
						<input class="span2" type="text" placeholder="Username" name="username">
						<input class="span2" type="password" placeholder="Password" name="password">
						<button type="submit" class="btn">登录</button>
						<a button type="button" class="btn" href="reg.jsp">注册</button></a>
					</form>		
					<% if (request.getSession().getAttribute("username") != null) out.write("-->"); %>
					<% if (request.getSession().getAttribute("username") == null) out.write("<!--"); %>
					<form class="navbar-form pull-right" action="index.jsp?iAction=logout" method="post">
						<span style="color: white;">
						<% if (request.getSession().getAttribute("username") != null)
							out.write("Hello!"+request.getSession().getAttribute("username").toString()+"  ");%>
						</span>
						<button type="submit" class="btn">登出</button>
					</form>
					<% if (request.getSession().getAttribute("username") == null) out.write("-->"); %>
				</div>
			</div>
		</div>
	</div>
	
	<%  
		String uid=null;
		if (request.getSession().getAttribute("username")!=null)  uid=request.getSession().getAttribute("id").toString();%>
	<% if (stb.isOrder(1,uid)) {%>
	<%
		ResultSet rs = null;
		rs = datainfo.getInfoData();
	%>
	
	<div class="container">
		<div class="hero-unit">
			<h2>Info公告</h2>
			<form class="navbar-form" >
				<table id="tb" class="datatb" cellspacing="0" width="100%" rules=all border frame=box>
				 <tr>
				 <td width="80%" align=center>公告</td><td width="10%" align=center>时间</td><td width="5%"></td><td width="5%" ></td>
				 </tr>
				<%
					while(rs.next())
					{				
						String cid=rs.getString("COMMENTID");
				%>
					<tr>
					<td ><a href=<%= rs.getString("LINK") %>><%= rs.getString("TITLE") %></a></td>
					<td><%= rs.getString("WHEN") %></td>
					<td align=center><a button type="button" class="btn btn-primary btn-small" href="ShareC.jsp?rk=<%=cid%>">转发</button></td>
					<td align=center><a button type="button" class="btn btn-primary btn-small" href="CommentC.jsp?rank=<%=cid%>">评论</button></td>
					</tr>
				<%
					}
				%>
					
				</table>
			</form>
			
			<br> </br>
		</div>
	<%} %> 
	
	<% if (stb.isOrder(2,uid)) {%>
	<%
		ResultSet rs = null;
		rs = datajiujing.getJiuJingData();
	%>
	
	<div class="container">
		<div class="hero-unit">
			<h2>系内公告</h2>
			<form class="navbar-form" >
				<table id="tb" class="datatb" cellspacing="0" width="100%" rules=all border frame=box>
				<tr>
				<td align=center width="10%">发布者</td><td align=center width="60%">内容</td><td align=center width="15%">时间</td><td width="5%"></td>
				</tr>
				<%
					while(rs.next())
					{											
				%>
					<tr>
					<td align=center><%= rs.getString("TITLE") %></td>
					<td><%= rs.getString("LINK") %></td>
					<td align=center><%= rs.getString("WHEN") %></td>
					<td align=center><a button type="button" class="btn btn-primary btn-small" href="CommentC.jsp?rank=<%=rs.getString("COMMENTID")%>">评论</button></td>
					</tr>
				<%
					}
				%>
					
				</table>
			</form>
			
			<br> </br>
		</div>
	<%} %>
	
	
	<% if (stb.isOrder(4,uid)) {%>
	<%
		//ResultSet rs = null;
		//rs = data.getRenrenData();
		String id=request.getSession().getAttribute("id").toString();
		RrFeed[] rF = datarenren.checkPass(id);
		
		
	%>
	
	<div class="container">
		<div class="hero-unit">
			<h2>人人信息</h2>
			<form class="navbar-form" >
				<table id="tb" class="datatb" cellspacing="0" width="100%" rules=all border frame=box>
				 <tr>
				 <td width="20%" align=center>类型</td><td width="55%" align=center>内容</td><td width="15%" align=center>时间</td><td width="5%"></td><td width="5%" ></td>
				 </tr>
				<%if (rF==null)  {%> <td>Wrong Log In For RenRen, Please Check Your Account!</td> <%} 
					else 
					{	
						
						String old=null;
						String type=null;
						
						//while(rs.next())
						for (int i=0;i<rF.length;i++)
						{	
							old=rF[i].getType();
							if (old.equals("SHARE_VIDEO")) old="分享视频";
							if (old.equals("UPDATE_STATUS")) old="更新状态";
							if (old.equals("PUBLISH_BLOG")) old="发表日志";
							if (old.equals("PUBLISH_ONE_PHOTO")) old="上传单张照片";
							if (old.equals("SHARE_PHOTO")) old="分享照片";
							if (old.equals("SHARE_ALBUM")) old="分享相册";
							if (old.equals("PUBLISH_MORE_PHOTO")) old="上传多张照片";
							if (old.equals("SHARE_LINK")) old="分享链接";
							if (old.equals("SHARE_BLOG")) old="分享日志";
							
				%>
				
					<tr>
					<td align=center><%= old    %></td>
					<td><%= rF[i].getSource()+":"+rF[i].getContent() %></td>
					<td align=center><%= rF[i].getTime()    %></td>
					<td align=center><a button type="button" class="btn btn-primary btn-small" href="ShareRr.jsp?rank=<%=((Integer)i).toString()%>">转发</button></td>
					 <td align=center><a button type="button" class="btn btn-primary btn-small" href="CommentRr.jsp?rank=<%=((Integer)i).toString()%>">评论</button></td>
					</tr>
				<%
						}
					}
				%>
					
				</table>
			</form>
			
			<br> </br>
		</div>
	<% }%>
	
	
	
		<hr>

		<footer>
			<p>&copy; null, Dept. CST, Tsinghua Univ., 2013</p>
		</footer>

	</div>
	
</body>
</html>