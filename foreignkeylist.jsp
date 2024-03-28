<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
    <%@ page import="java.sql.*" %>
	<%@ page import="javax.swing.*" %>
<%
	try
	{
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
		Statement smt = conn.createStatement();
		ResultSet rs = smt.executeQuery("select * from bank");
%>	
		Bank id <select name=g>
<%
		while(rs.next())
		{
%>
			<option><%=rs.getString(1)%></option>
<%
		}
%>
		</select>
		Addresses id <select name=k>
<%
		rs = smt.executeQuery("select * from addresses");
		while(rs.next())
		{
%>
			<option><%=rs.getString(1)%></option>
<%
		}


	} 
	catch (Exception e) 
	{
		out.println(e.toString());
	}
	

%>
</body>
</html>
