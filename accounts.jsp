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
			int c=0;
			int a=0;
			int t=0;
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
				Statement smt = conn.createStatement();
				
				
				// To check account number Primary key
				ResultSet rs = smt.executeQuery("select * from Accounts");
				while (rs.next())
				{
				   if(rs.getString(1).equals(t1))
				   {
							f=1;
							break;
					}
				}
				
				
				//To check customer id as foreign key
				rs = smt.executeQuery("select * from customer");
				while (rs.next())
				{
				   if(rs.getString(1).equals(t2))
				    {
							c=1;
							break;
					}
				}
				
				//To check account status code as foreign key
				rs = smt.executeQuery("select * from dimtransactiontype");
				while (rs.next())
				{
				   if(rs.getString(1).equals(t3))
				    {
							a=1;
							break;
					}
				}
				
				//To check Account type code id as foreign key
				rs = smt.executeQuery("select * from ref_account_type");
				while (rs.next())
				{
				   if(rs.getString(1).equals(t4))
				   {
							t=1;
							break;
					}
				}
				
				
				
				
				if(f==1)
					out.println("<script>alert('Accounts ID already exists......')</script>");
				else if(c==0)
					out.println("<script>alert('Customer id is not valid.....')</script>");
				else if(a==0)
					out.println("<script>alert('Account status code is not valid......')</script>");
				else if(t==0)
					out.println("<script>alert('account type code is not valid......')</script>");
				else if(f==0 && c==1 && a==1 && t==1)
			{
				PreparedStatement psmt=conn.prepareStatement("insert into accounts values(?,?,?,?)");
				psmt.setString(1,t1);
				psmt.setString(2,t2);
				psmt.setString(3,t3);
				psmt.setString(4,t4);
				psmt.executeQuery();
				out.println("<script>alert('Record saved......')</script>");
			}
			}
			catch(Exception e)
			{
				out.println(e.toString());
			}
		}//End of save
		
		//delete the record
		if(btnval.equalsIgnoreCase("Delete"))
		{
			String t1=request.getParameter("t1");
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");  
				Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
				PreparedStatement psmt=conn.prepareStatement("delete from accounts where account_number=?");
				psmt.setString(1,t1);
				psmt.executeQuery();
				out.println("<script>alert('Record delete......')</script>");
			}
			catch(Exception e)
			{
				out.println(e.toString());
			}
		}//End of delete
		
		
		
		
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
				PreparedStatement psmt=conn.prepareStatement("Update accounts set customer_id=?, account_status_code=?, account_type_code=? where account_number=?");
				psmt.setString(4,t1);
				psmt.setString(1,t2);
				psmt.setString(2,t3);
				psmt.setString(3,t4);
				psmt.executeQuery();
				out.println("<script>alert('Update saved......')</script>");
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
						ResultSet rs=smt.executeQuery("select * from accounts");
		    %>
						<table border=2>
						<tr>
							<th>Account Number</th>
							<th>Customer ID</th>
							<th>Account Status Code</th>
							<th>Account type code</th>
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
						ResultSet rs=smt.executeQuery("select * from accounts where account_number='"+t1+"'");
		    %>
						<table border=2>
						<tr>
							<th>Account Number</th>
							<th>Customer ID</th>
							<th>Account Status Code</th>
							<th>Account type code</th>
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
				
				
				
				// All Search by Column 
			    
				   if(btnval.equalsIgnoreCase("find")) 
				    { 
				     String t1=request.getParameter("t1"); 
				     String colnm=request.getParameter("s1"); 
				     try 
				     { 
				      Class.forName("oracle.jdbc.driver.OracleDriver"); 
				      Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","bank","bank"); 
				      Statement smt=conn.createStatement(); 
				      ResultSet rs=smt.executeQuery("select * from accounts where"+" "+colnm+"="+"'"+t1+"'"); 
				      %> 
				      <table border=2> 
				      <tr> 
				       <th>Account Number</th> 
				       <th>Customer Id</th> 
				       <th>Account Status Code</th> 
				       <th>Account Type Code</th> 
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
				   <%         } 
				      %> 
				       <input type=button value="Print" onclick="window.print()"> 
				      </table> 
				      <%  } 
				      catch(Exception e) 
				      { 
				      out.println(e.toString()); 
				      } 
				     }//end of Search by Column
				    
				    
				    
				    //primary key check
					if(btnval.equalsIgnoreCase("New"))
				   {
						String t1 = request.getParameter("t1");
						int f=0;
				try
	   		 	{
					Class.forName("oracle.jdbc.driver.OracleDriver");
					Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
					Statement smt = conn.createStatement();
					ResultSet rs = smt.executeQuery("select * from Accounts");
					while (rs.next())
					{
					   if(rs.getString(1).equals(t1))
					   {
								f=1;
								break;
						}
					}
					if(f==1)
						out.println("Already exists");
					else
						out.println("Not available");
			    } 
					catch (Exception e) 
				{
		    		 out.println(e.toString());
				}
			}  //end of Primary key check
	%>
	
</body>
</html>