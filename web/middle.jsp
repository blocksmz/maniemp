<%-- 
    Document   : middle
    Created on : Jul 22, 2016, 10:50:12 AM
    Author     : blocks
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="3;url=index.html"> 
        <title>redirect page</title>
    </head>
    <body>
        
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
            int no=0;
            String name="";
            String job="";
            float sal=0;
            String date="0000-00-00";
            

            no=Integer.parseInt(request.getParameter("tno"));
            
            name=request.getParameter("tname");
            
            job=request.getParameter("tjob");
            
            sal=Float.parseFloat(request.getParameter("tsal"));
            
            date=request.getParameter("tdate");

        %>
        
        
        <h3>操作成功，3秒钟后跳转到首页</h3>
        <h3>如3秒后未跳转请点击<a href="index.html">这里</a></h3>
        <%
            response.setHeader("refresh", "3;URL=index.html");
        %>
        
        
        
         <%
             
             if(request.getParameter("tname")!=null)
             {
            try
            {
            Class.forName(DBDRIVER);
            con=DriverManager.getConnection(DBURL,DBUSER,DBPASS);
            
            String sql="update emp set empno="+Integer.parseInt(request.getParameter("tno"))+",ename='"+request.getParameter("tname")+"',job='"+request.getParameter("tjob")+"',hiredate='"+request.getParameter("tdate")+"',sal="+Float.parseFloat(request.getParameter("tsal"))+" where empno="+Integer.parseInt(request.getParameter("tno"));
            
            stmt=con.prepareStatement(sql);
            
            boolean flag=stmt.execute();
            
            stmt.close();
            con.close();
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
             }


             if(request.getParameter("vf")!=null)
             {
                 
                  try
            {
            Class.forName(DBDRIVER);
            con=DriverManager.getConnection(DBURL,DBUSER,DBPASS);
            
            String sql="delete from emp where empno="+Integer.parseInt(request.getParameter("tno"));
            
            stmt=con.prepareStatement(sql);
            
            boolean flag=stmt.execute();
            
            stmt.close();
            con.close();
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
             }
            %>
            
            

    </body>
</html>
