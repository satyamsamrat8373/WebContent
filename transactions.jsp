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
			int t=0;
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");  
				Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
				Statement smt = conn.createStatement();
				
				// To check Transaction ID Primary key
				ResultSet rs = smt.executeQuery("select * from transactions");
				while (rs.next())
				{
				   if(rs.getString(1).equals(t1))
				   {
							f=1;
							break;
					}
				}
				
				
				
				//To check account number as foreign key
				rs = smt.executeQuery("select * from accounts");
				while (rs.next())
				{
				   if(rs.getString(1).equals(t2))
				   {
							a=1;
							break;
					}
				}
				
				//To check Trans type code id as foreign key
				rs = smt.executeQuery("select * from dimtransactiontype");
				while (rs.next())
				{
				   if(rs.getString(1).equals(t3))
				   {
							t=1;
							break;
					}
				}
				
				
				
				
				if(f==1)
					out.println("<script>alert('Transactions ID already exists......')</script>");
				else if(a==0)
					out.println("<script>alert('Account number is not valid......')</script>");
				else if(t==0)
					out.println("<script>alert('Trans type code is not valid......')</script>");
				else if(f==0 && a==1 && t==1)
			{
				PreparedStatement psmt=conn.prepareStatement("insert into transactions values(?,?,?,?,?)");
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
				PreparedStatement psmt=conn.prepareStatement("Delete from transactions where transation_id=?");
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
				PreparedStatement psmt=conn.prepareStatement("Update transactions set account_number=?,trans_type_code=?,dt_time=?,transaction_amount=? where transation_id=?");
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
		}//End of Update
		
		
		
		//Display all records
				if(btnval.equalsIgnoreCase("allSearch"))
				{
					try
					{
						Class.forName("oracle.jdbc.driver.OracleDriver");
						Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","bank","bank");
						Statement smt=conn.createStatement();
						ResultSet rs=smt.executeQuery("select * from transactions");
		    %>
						<table border=2>
						<tr>
							<th>Transation ID</th>
							<th>Account Number</th>
							<th>Trans type code</th>
							<th>DT time</th>
							<th>Transaction Amount</th>
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
						ResultSet rs=smt.executeQuery("select * from transactions where transation_id='"+t1+"'");
		    %>
						<table border=2>
						<tr>
							<th>Transation ID</th>
							<th>Account Number</th>
							<th>Trans type code</th>
							<th>DT time</th>
							<th>Transaction Amount</th>
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
				ResultSet rs = smt.executeQuery("select * from transactions  where"+" "+colnm + "="+ "'"+t1+"'");
				%>
				<table border=2>
					<tr>
						<th>Transation _ID</th>
						<th>Account_Number</th>
						<th>Trans_type_code</th>
						<th>DT_Time</th>
						<th>Transaction_Amount</th>
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