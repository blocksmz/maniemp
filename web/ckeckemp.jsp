<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<html>
<head>
        <title>查询雇员信息</title>
</head>

<body>
    <div style="float:right">
        <form action="ckeckemp.jsp" method="post">
        输入关键字<input type="text" name="keword" id="kword" >
        <input type="submit" value="查找">
        </form>
    </div>   
    
<%!
        public static final String DBDRIVER="org.mariadb.jdbc.Driver";
        public static final String DBURL="jdbc:mariadb://localhost:3306/mldn";
        public static final String DBUSER="blocksmz";
        public static final String DBPASS="MRZHAo0928";
%>
<%
        Connection conn=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;
        class contain{
            public contain(int empno,java.lang.String ename,java.lang.String job,float sal,java.util.Date date)
            {
                this.empno=empno;
                this.ename=ename;
                this.job=job;
                this.sal=sal;
                this.date=date;
            }
             public    int empno;
             public   java.lang.String ename;
             public   java.lang.String job;
             public   float sal;
             public   java.util.Date date;
        }
        
        java.util.LinkedList<contain> cont=new java.util.LinkedList<contain>();
        int count=0;
        String keyword="null";
%>

<%
        try
        {
                Class.forName(DBDRIVER);
                conn=DriverManager.getConnection(DBURL,DBUSER,DBPASS);
                String sql="SELECT empno,ename,job,sal,hiredate FROM emp";
                keyword=String.valueOf(request.getParameter("keword"));

                if(!keyword.equals("null"))
                {
                    System.out.println("before the second sql!");
                sql="SELECT empno,ename,job,sal,hiredate FROM emp where empno like '%"+keyword+"%' or ename like '%"+keyword+"%'"
                        + " or job like '%"+keyword+"%' or sal like '%"+keyword+"%' or hiredate like '%"+keyword+"%'";
                }
                System.out.println(sql);
                pstmt=conn.prepareStatement(sql);
                rs=pstmt.executeQuery();
            
%>
<table>

<center>
                <tr>
                        <td>雇员编号</td>
                        <td>雇员姓名</td>
                        <td>雇员工作</td>
                        <td>雇员工资</td>
                        <td>雇佣日期</td>
                </tr>
</center>
<%
        while(rs.next()){       //加入列表
                int empno=rs.getInt(1);
                String ename=rs.getString(2);
                String job=rs.getString(3);
                float sal=rs.getFloat(4);
                java.util.Date date=rs.getDate(5);
                
                cont.add(new contain(empno,ename,job,sal,date));
                count++;
                
                 }
        
        
        
        int bcount=0;            //0-每页条目数
        int ttarget=0;          //页数，0计数
        if(request.getParameter("countvalue")!=null)
            {
               ttarget=Integer.parseInt(request.getParameter("countvalue"));
            }

        
        while(bcount<5)     //输出
        {
            if(bcount+ttarget*5>=count)
            {
                break;
            }
            
            contain inwhile=cont.get(ttarget*5+bcount);     //临时值
%>
<center>     
<tr>
    <td><%=inwhile.empno%></td>
    <td><%=inwhile.ename%></td>
    <td><%=inwhile.job%></td>
    <td><%=inwhile.sal%></td>
    <td><%=inwhile.date%></td>
</tr>
</center>
    <br>
<%
        bcount++;
       }

       //设置计数值
       int start=0;
       int end=count/5;
       System.out.println("endvalue");
       System.out.println(end);
        int before;
       if(ttarget!=0)
        {
             before=ttarget-1;
        }else
        {
             before=0;
        }
        int after=ttarget+1;
        if(after>end)
        {
                after=end;
        }
        else
        {
                 after=ttarget+1;
        }
%>
        
</table>
<div>
    <a href="ckeckemp.jsp?countvalue=<%=start%>&keword=<%=keyword%>">首页</a><a href="ckeckemp.jsp?countvalue=<%=before%>&keword=<%=keyword%>">上一页</a>
    <a href="ckeckemp.jsp?countvalue=<%=after%>&keword=<%=keyword%>">下一页</a><a href="ckeckemp.jsp?countvalue=<%=end%>&keword=<%=keyword%>">尾页</a>
</div>

<%
}
catch(Exception e){
        System.out.println(e);
}finally{
      
	 if(rs!=null)

    try{

        rs.close();

    }catch(SQLException e)

    {

      e.printStackTrace();

    }

	 if(pstmt!=null)

    try{

        pstmt.close();

    }catch(SQLException e)

    {

      e.printStackTrace();

    }

	 if(conn!=null)

    try{

        conn.close();

    }catch(SQLException e)

    {

      e.printStackTrace();

    }

}
%>
</body>
</html>
