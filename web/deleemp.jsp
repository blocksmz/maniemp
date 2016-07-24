<%-- 
    Document   : deleemp
    Created on : Jul 23, 2016, 10:32:09 AM
    Author     : blocks
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>

        <title>删除雇员信息</title>
    </head>
    <body>
    <center>
        <form action="deleemp.jsp" method="post">
        输入雇员编号<input type="text" name="tno">
        <input type="submit" value="确定">
        </form>
        
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
            
            int no=0;
            String name="";
            String job="";
            float sal=0;
            String date="";
        %>
            
        <%
            try
            {
            Class.forName(DBDRIVER);
            con=DriverManager.getConnection(DBURL,DBUSER,DBPASS);
            
            String sql="select empno,ename,job,hiredate,sal from emp where empno='"+request.getParameter("tno")+"'";
            
            stmt=con.prepareStatement(sql);
            
            rs=stmt.executeQuery();
            
            if(rs.next())
            {
                no=rs.getInt(1);
                name=rs.getString(2);
                job=rs.getString(3);
                sal=rs.getFloat(5);
                date=rs.getString(4);
            }
            
            rs.close();
            stmt.close();
            con.close();
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }

            %>
          <center>  
            <form action="middle.jsp" method="post">
            <table>
                <tr>
                    <td>  职员编号</td><td><input type="text" name="tno" value=<%=no%>></td>
                    
                </tr>
                <tr>
                    <td>
                        职员姓名</td><td><input type="text" name="tname" value=<%=name%>>
                    </td>
                </tr>
                
                <tr>
                    <td>
                        职员工作</td><td><input type="text" name="tjob" value=<%=job%>>
                    </td>
                </tr>
                
                <tr>
                    <td>
                        雇佣日期</td>
                    <td>
                        <input type="text" name="tdate" value=<%=date%>>
                    </td>
                </tr>
                
                
                <tr>
                    <td>
                        职员薪资</td><td><input type="text" name="tsal" value=<%=sal%>>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="hidden" name="vf" value="to">
                    </td>
                </tr>
                
                <tr>
                    <td>
                        <input type="submit" value="删除">
                    </td>
                    <td>
                        <input type="reset" value="取消">
                    </td>
                </tr>

            </table>
            </form>
        
    </center>
        
    </body>
</html>
