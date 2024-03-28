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
			int f=0;
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");  
				Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
				Statement smt = conn.createStatement();
				
				// To check Trans type code Primary key
				ResultSet rs = smt.executeQuery("select * from dimtransactiontype");
				while (rs.next())
				{
				   if(rs.getString(1).equals(t1))
				   {
							f=1;
							break;
					}
				}
				if(f==1)
					out.println("Trans type code Already exists");
				else
			{
				PreparedStatement psmt=conn.prepareStatement("insert into dimtransactiontype values(?,?)");
				psmt.setString(1,t1);
				psmt.setString(2,t2);
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
				PreparedStatement psmt=conn.prepareStatement("Delete from dimtransactiontype where trans_type_code=?");
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
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");  
				Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
				PreparedStatement psmt=conn.prepareStatement("update dimtransactiontype set trans_desc=? where trans_type_code=?");
				psmt.setString(2,t1);
				psmt.setString(1,t2);
				psmt.executeQuery();
				out.println("<script>alert('Record update......')</script>");
			}
			catch(Exception e)
			{
				out.println(e.toString());
			}
		}//End of Update
		
		
		
		//Display all search
				if(btnval.equalsIgnoreCase("allSearch"))
				{
					try
					{
						Class.forName("oracle.jdbc.driver.OracleDriver");
						Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","bank","bank");
						Statement smt=conn.createStatement();
						ResultSet rs=smt.executeQuery("select * from dimtransactiontype");
		    %>
						<table border=2>
						<tr>
							<th>Trans Tpe Code</th>
							<th>Trans desc</th>
						</tr>
		    <%
						while(rs.next())
						{
			%>
							<tr>
								<th><%=rs.getString(1)%></th>
				  				<th><%=rs.getString(2)%></th>
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
						ResultSet rs=smt.executeQuery("select * from dimtransactiontype where trans_type_code='"+t1+"'");
		    %>
						<table border=2>
						<tr>
							<th>Trans Tpe Code</th>
							<th>Trans desc</th>
						</tr>
		    <%
						while(rs.next())
						{
			%>
							<tr>
								<th><%=rs.getString(1)%></th>
				  				<th><%=rs.getString(2)%></th>
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
				ResultSet rs = smt.executeQuery("select * from dimtransactiontype where"+" "+colnm + "="+ "'"+t1+"'");
				%>
				<table border=2>
					<tr>
						<th>Trans_type_code</th>
						<th>Trans_desc</th>
					</tr>
					<%
					while (rs.next()) {
					%>
					<tr>
						<th><%=rs.getString(1)%></th>
						<th><%=rs.getString(2)%></th>
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