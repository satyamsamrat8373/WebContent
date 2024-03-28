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
			String t5=request.getParameter("t5");
			int f=0;
			int a=0;
			int b=0;
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");  
				Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
				Statement smt = conn.createStatement();
				
				// To check Customer ID Primary key
				ResultSet rs = smt.executeQuery("select * from customer");
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
				
				//To check branch id as foreign key
				rs = smt.executeQuery("select * from branches");
				while (rs.next())
				{
				   if(rs.getString(1).equals(t3))
				   {
							b=1;
							break;
					}
				}
				
				
				
				
				if(f==1)
					out.println("<script>alert('Customer ID already exists.....')</script>");
				else if(a==0)
					out.println("<script>alert('Address id is not valid.....')</script>");
				else if(b==0)
					out.println("<script>alert('Branch id is not valid......')</script>");
				else if(f==0 && a==1 && b==1)
			   {
				PreparedStatement psmt=conn.prepareStatement("insert into customer values(?,?,?,?,?)");
				psmt.setString(1,t1);
				psmt.setString(2,t2);
				psmt.setString(3,t3);
				psmt.setString(4,t4);
				psmt.setString(5,t5);
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
				PreparedStatement psmt=conn.prepareStatement("Delete from customer where customer_id=?");
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
			String t5=request.getParameter("t5");
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");  
				Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
				PreparedStatement psmt=conn.prepareStatement("Update customer set address_id=?,branch_id=?,gender=?,contact=? where customer_id=?");
				psmt.setString(5,t1);
				psmt.setString(1,t2);
				psmt.setString(2,t3);
				psmt.setString(3,t4);
				psmt.setString(4,t5);
				psmt.executeQuery();
				out.println("<script>alert('Record Update......')</script>");
			}
			catch(Exception e)
			{
				out.println(e.toString());
			}
		}//End of update
		
		
		
		//Display all records
				if(btnval.equalsIgnoreCase("allSearch"))
				{
					try
					{
						Class.forName("oracle.jdbc.driver.OracleDriver");
						Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","bank","bank");
						Statement smt=conn.createStatement();
						ResultSet rs=smt.executeQuery("select * from customer");
		    %>
						<table border=2>
						<tr>
							<th>Customer ID</th>
							<th>Address ID</th>
							<th>Branch ID</th>
							<th>Gender</th>
							<th>Contact</th>
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
				  				<th><%=rs.getString(5)%></th>
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
		
				
				
				//Display all psearch
				if(btnval.equalsIgnoreCase("pSearch"))
				{
					String t1=request.getParameter("t1");
					try
					{
						Class.forName("oracle.jdbc.driver.OracleDriver");
						Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","bank","bank");
						Statement smt=conn.createStatement();
						ResultSet rs=smt.executeQuery("select * from customer where customer_id='"+t1+"'");
		    %>
						<table border=2>
						<tr>
							<th>Customer ID</th>
							<th>Address ID</th>
							<th>Branch ID</th>
							<th>Gender</th>
							<th>Contact</th>
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
				  				<th><%=rs.getString(5)%></th>
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
			 	}//end of all psearch
				
				
				//Search of drop down box 
				if (btnval.equalsIgnoreCase("find")) {
				String t1 = request.getParameter("t1");
				String colnm=request.getParameter("s1");
				try {
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
				Statement smt = conn.createStatement();
				ResultSet rs = smt.executeQuery("select * from customer where"+" "+colnm + "="+ "'"+t1+"'");
				%>
				<table border=2>
					<tr>
						<th>customer_ID</th>
						<th>Address_ID</th>
						<th>Branch_ID</th>
						<th>Gender</th>
						<th>contact</th>
					</tr>
					<%
					while (rs.next()) {
					%>
					<tr>
						<th><%=rs.getString(1)%></th>
						<th><%=rs.getString(2)%></th>
						<th><%=rs.getString(3)%></th>
						<th><%=rs.getString(4)%></th>
						<th><%=rs.getString(5)%></th>
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