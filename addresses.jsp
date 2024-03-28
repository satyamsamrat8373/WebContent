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
				String t6=request.getParameter("t6");
				String t7=request.getParameter("t7");
				int f=0;
				try
				{
					Class.forName("oracle.jdbc.driver.OracleDriver");
					Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
					Statement smt = conn.createStatement();
					
					
					// To check Address ID Primary key
					ResultSet rs = smt.executeQuery("select * from Addresses");
					while (rs.next())
					{
					   if(rs.getString(1).equals(t1))
					   {
								f=1;
								break;
						}
					}
					if(f==1)
						out.println("Address ID Already exists");
					else
				{
					PreparedStatement psmt=conn.prepareStatement("insert into addresses values(?,?,?,?,?,?,?)");
					psmt.setString(1,t1);
					psmt.setString(2,t2);
					psmt.setString(3,t3);
					psmt.setString(4,t4);
					psmt.setString(5,t5);
					psmt.setString(6,t6);
					psmt.setString(7,t7);
					psmt.executeQuery();
					out.println("<script>alert('Record Saved......')</script>");
				}
				}
					catch(Exception e)
				{
					out.println(e.toString());
				}
		}			//End of save Of Primary Key
		
		//delete the record
				if(btnval.equalsIgnoreCase("Delete"))
				{
					String t1=request.getParameter("t1");
					try
					{
						Class.forName("oracle.jdbc.driver.OracleDriver");  
						Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
						PreparedStatement psmt=conn.prepareStatement("delete from addresses where addres_id=?");
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
			String t5=request.getParameter("t5");
			String t6=request.getParameter("t6");
			String t7=request.getParameter("t7");
			
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");  
				Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bank", "bank");
				PreparedStatement psmt=conn.prepareStatement("update addresses set line_1=?,line_2=?,town_city=?,zip_code=?,country=?,other_details=? where addres_id=?");
				psmt.setString(7,t1);
				psmt.setString(1,t2);
				psmt.setString(2,t3);
				psmt.setString(3,t4);
				psmt.setString(4,t5);
				psmt.setString(5,t6);
				psmt.setString(6,t7);
				psmt.executeQuery();
				out.println("<script>alert('Record update......')</script>");
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
					ResultSet rs=smt.executeQuery("select * from addresses");
	    %>
					<table border=2>
					<tr>
						<th>Address ID</th>
						<th>Line 1</th>
						<th>Line 2</th>
						<th>Town city</th>
						<th>Zip code</th>
						<th>country</th>
						<th>Bank Details</th>
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
			  				<th><%=rs.getString(6)%></th>
			  				<th><%=rs.getString(7)%></th>
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
					ResultSet rs=smt.executeQuery("select * from addresses where addres_id='"+t1+"'");
	    %>
					<table border=2>
					<tr>
						<th>Address ID</th>
						<th>Line 1</th>
						<th>Line 2</th>
						<th>Town city</th>
						<th>Zip code</th>
						<th>country</th>
						<th>Bank Details</th>
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
			  				<th><%=rs.getString(6)%></th>
			  				<th><%=rs.getString(7)%></th>
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
			ResultSet rs = smt.executeQuery("select * from addresses where"+" "+colnm + "="+ "'"+t1+"'");
			%>
			<table border=2>
				<tr>
					<th>Addres ID</th>
					<th>Line 1</th>
					<th>Line 2</th>
					<th>Town city</th>
					<th>Zip code</th>
					<th>country</th>
					<th>other details</th>
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
					<th><%=rs.getString(6)%></th>
					<th><%=rs.getString(7)%></th>
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
			ResultSet rs = smt.executeQuery("select * from Addresses");
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