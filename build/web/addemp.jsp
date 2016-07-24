<%-- 
    Document   : addemp
    Created on : Jul 22, 2016, 10:12:14 AM
    Author     : blocks
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>添加职员信息</title>
    </head>
    <body>
    <center>
        <h1>添加职员信息</h1>
        
        <%!
            public static final String DBDRIVER="org.mariadb.jdbc.Driver";
            public static final String DBURL="jdbc:mariadb://localhost:3306/mldn";
            public static final String DBUSER="blocksmz";
            public static final String DBPASS="MRZHAo0928";

        %>
        
        <%
            
            request.setCharacterEncoding("utf-8");
            Connection con=null;
            PreparedStatement stmt=null;
            ResultSet rs=null;
        %>
        
      
        <%
            try{
                Class.forName(DBDRIVER);
                con=DriverManager.getConnection(DBURL,DBUSER,DBPASS);
                
                String sql="insert into emp(empno,ename,job,hiredate,sal)values("+request.getParameter("eno")+",'"+request.getParameter("ename")
                        +"','"+request.getParameter("ejob")+"','"+request.getParameter("hiredate")+"',"+request.getParameter("esal")+")";
                        
                stmt=con.prepareStatement(sql);
                stmt.execute();
                
                stmt.close();
                con.close();
                
                
            }catch(Exception e)
            {
                e.printStackTrace();
            }
        
            %>
            
            
             <%response.sendRedirect("middle.jsp");%>
    </center>
    </body>
</html>
