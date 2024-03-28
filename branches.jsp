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
		String btnval=request.getParameter("b1");
		if(btnval.equalsIgnoreCase("Save"))
		{
			String t1=request.getParameter("t1");
			String t2=request.getParameter("t2");
			String t3=request.getParameter("t3");
			String t4=request.getParameter("t4");
			int f=0;
			int a=0;
			int b=0;
			int b1=0;
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");  
				Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
				Statement smt = conn.createStatement();
				
				
				// To check Branch ID Primary key
				ResultSet rs = smt.executeQuery("select * from branches");
				while (rs.next())
				{
				   if(rs.getString(1).equals(t1))
				   {
							f=1;
							break;
					}
				}
				
				//To check address id as foreign key
				rs = smt.executeQuery("select * from addresses");
				while (rs.next())
				{
				   if(rs.getString(1).equals(t2))
				   {
							a=1;
							break;
					}
				}
				
				//To check bank id as foreign key
				rs = smt.executeQuery("select * from bank");
				while (rs.next())
				{
				   if(rs.getString(1).equals(t3))
				   {
							b=1;
							break;
					}
				}
				
				//To check branch type code id as foreign key
				rs = smt.executeQuery("select * from ref_branch_type");
				while (rs.next())
				{
				   if(rs.getString(1).equals(t4))
				   {
							b1=1;
							break;
					}
				}
				
				
				
				
				if(f==1)
					out.println("<script>alert('Branch ID already exists......')</script>");
				else if(a==0)
					out.println("<script>alert('Address id is not valid.....')</script>");
				else if(b==0)
					out.println("<script>alert('Bank id is not valid......')</script>");
				else if(b1==0)
					out.println("<script>alert('Branch type code is not valid......')</script>");
				else if(f==0 && a==1 && b==1 && b1==1)
			{
				PreparedStatement psmt=conn.prepareStatement("insert into branches values(?,?,?,?)");
				psmt.setString(1,t1);
				psmt.setString(2,t2);
				psmt.setString(3,t3);
				psmt.setString(4,t4);
				psmt.executeQuery();
				out.println("<script>alert('Record Saved......')</script>");
			}
			}
			catch(Exception e)
			{
				out.println(e.toString());
			}
		}//End of save
		
		
		//Delete the record
		if(btnval.equalsIgnoreCase("Delete"))
		{
			String t1=request.getParameter("t1");
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");  
				Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
				PreparedStatement psmt=conn.prepareStatement("Delete from branches where branch_id=?");
				psmt.setString(1,t1);
				psmt.executeQuery();
				out.println("<script>alert('Record Delete......')</script>");
			}
			catch(Exception e)
			{
				out.println(e.toString());
			}
		}//End of Delete
		
		
		//Update the record
		if(btnval.equalsIgnoreCase("Update"))
		{
			String t1=request.getParameter("t1");
			String t2=request.getParameter("t2");
			String t3=request.getParameter("t3");
			String t4=request.getParameter("t4");
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");  
				Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
				PreparedStatement psmt=conn.prepareStatement("Update branches set address_id=?,bank_id=?,branch_type_code=? where branch_id=?");
				psmt.setString(4,t1);
				psmt.setString(1,t2);
				psmt.setString(2,t3);
				psmt.setString(3,t4);
				psmt.executeQuery();
				out.println("<script>alert('Record update......')</script>");
			}
			catch(Exception e)
			{
				out.println(e.toString());
			}
		}//End of Update
		
		//All search
		
		if(btnval.equalsIgnoreCase("allSearch"))
		{
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","bank","bank");
				Statement smt=conn.createStatement();
				ResultSet rs=smt.executeQuery("select * from branches");
    %>
				<table border=2>
				<tr>
					<th>Branch ID</th>
					<th>Address Details</th>
					<th>Bank ID</th>
					<th>Branch Type Code</th>
				</tr>
    <%
				while(rs.next())
				{
	%>
					<tr>
						<th><%=rs.getString(1)%></th>
		  				<th><%=rs.getString(2)%></th>
		  				<th><%=rs.getString(3)%></th>
		  				<th><%=rs.getString(4)%></th>
					</tr>
	<%	        }
    %>
					<input type=button value="Print" onclick="window.print()">
				</table>
    <%		}
		  catch(Exception e)
		  {
				out.println(e.toString());
		  }
	 	}//end of all search
		
		
		
		//Display Particular Search
		if(btnval.equalsIgnoreCase("pSearch"))
		{
			String t1=request.getParameter("t1");
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","bank","bank");
				Statement smt=conn.createStatement();
				ResultSet rs=smt.executeQuery("select * from branches where branch_id='"+t1+"'");
    %>
				<table border=2>
				<tr>
					<th>Branch ID</th>
					<th>Address Details</th>
					<th>Bank ID</th>
					<th>Branch Type Code</th>
				</tr>
    <%
				while(rs.next())
				{
	%>
					<tr>
						
						<th><%=rs.getString(1)%></th>
		  				<th><%=rs.getString(2)%></th>
		  				<th><%=rs.getString(3)%></th>
		  				<th><%=rs.getString(4)%></th>
					</tr>
	<%	        }
    %>
					<input type=button value="Print" onclick="window.print()">
				</table>
    <%		}
		  catch(Exception e)
		  {
				out.println(e.toString());
		  }
	 	}//end of all particular search
		
		
		
		//Search of drop down box 
		if (btnval.equalsIgnoreCase("find")) {
		String t1 = request.getParameter("t1");
		String colnm=request.getParameter("s1");
		try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
		Statement smt = conn.createStatement();
		ResultSet rs = smt.executeQuery("select * from branches where"+" "+colnm + "="+ "'"+t1+"'");
		%>
		<table border=2>
			<tr>
				<th>Branch_ID</th>
				<th>Address_ID</th>
				<th>Bank_ID</th>
				<th>Branch_type_code</th>
			</tr>
			<%
			while (rs.next()) {
			%>
			<tr>
				<th><%=rs.getString(1)%></th>
				<th><%=rs.getString(2)%></th>
				<th><%=rs.getString(3)%></th>
				<th><%=rs.getString(4)%></th>
			</tr>
			<%
			}
			%>
			<input type=button value="Print" onclick="window.print()">
		</table>
		<%
		} catch (Exception e) {
		out.println(e.toString());
		}
		}
	%>
	
	
</body>
</html>