<!DOCTYPE html>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%
	String u_email=(String)session.getAttribute("u_email");
	String u_name=(String)session.getAttribute("u_name");
	if(u_email!=null){
%>
<html>
    <head>
        <title>Auto Insurance</title>
        <link rel="icon" href="resource/autoinsurance-icon.png"/>
        
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
        
        <!-- AOS css and JS -->
        <link rel="stylesheet" href="resource/aos/aos.css">
        <script src="resource/aos/aos.js"></script>
        <!-- AOS css and JS END-->

        <!-- fontawesome -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" >
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <!-- fontawesome END -->

        <!-- Lightbox CSS & Script -->
        <script src="resource/lightbox/ekko-lightbox.js"></script>
        <link rel="stylesheet" href="resource/lightbox/ekko-lightbox.css"/>

        

        <!-- custom css-->
        <link rel="stylesheet" href="resource/custom.css"/>
        <!-- custom css END-->

        <meta name="author" content="Rahul Chauhan"/>
        <meta name="description" content="This is a Auto Insurance website"/>
        <meta name="keywords" content="best Insurance comapny in noida"/>
    </head>
    <body>
    	<!-- Code for message receiving  -->
		<%
			String m=(String)session.getAttribute("msg");
			if(m!=null){
		%>
			<div class="alert alert-danger text-center" role="alert">
			  <%=m %>
			</div>
 
		<%
			session.setAttribute("msg",null);
			}
		%>
        <nav class="navbar navbar-expand-sm sticky-top bg-light">
            <a class="navbar-brand c-font" href="">
              <img class="navbar-brand c-font" src='resource/autoinsurance-icon.png' width="30px"/> <span class="text-danger font-weight-bold ">Auto</span><span class="text-muted">Insurance</span>
            </a>
            <button class="navbar-toggler bg-light" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
                <!-- <span class="navbar-toggler-icon text-dark"> <i class="fas fa-sort-down"></i> </span> -->
                <span class="fa fa-bars"></span> Menu
            </button>
            <div class="collapse navbar-collapse " id="collapsibleNavbar"  >
              <ul class="navbar-nav mx-auto ">
                <li class="nav-item">
                  <a class="nav-link text-secondary" href="index.jsp">HOME</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link text-secondary" href="UserHome.jsp">Profile</a>
                </li>
                <li class="nav-item">
                	<label class="nav-link"> 
                	Welcome: <b><%=u_name %></b> 
                	<img src='GetPhoto?email=<%=u_email%>&type=user' height='30'/>
                	</label>
                </li>
                <li class="nav-item">
                  <a class="nav-link text-secondary" href="UserInsurance.jsp">Insurance</a>
                </li> 
                <li class="nav-item">
                  <a class="nav-link text-secondary" href="Logout">Logout</a>
                </li>    
              </ul>
              <div >
                  <a class="text-danger h5 mr-3" href="tel:+91-9811981198">CALL US TODAY: +91-9811981198</a>
              </div>
            </div>
        </nav>
        
        <div class='container p-4'>
       		<%
       		dao.DbConnect db=new dao.DbConnect();
       		ArrayList<HashMap<String, Object>> policies=db.getPoliciesByUser(u_email);
       		for(HashMap<String, Object> policy_order:policies){
    		%>	
    			<div class='bg-light p-3' >
    				<%
    				int oid=(int)policy_order.get("oid");
    				int pid=(int)policy_order.get("pid");
    				String v_no=(String)policy_order.get("v_no");
    				String e_no=(String)policy_order.get("e_no");
    				java.sql.Date c_date=(java.sql.Date)policy_order.get("c_date");
    				
    				HashMap<String, Object> policy_details=db.getPolicyByID(pid);
    				String p_name=(String)policy_details.get("p_name");
    				int p_si_amt=(int)policy_details.get("p_si_amt");
    				String c_email=(String)policy_details.get("c_email");
    				String p_desc=(String)policy_details.get("p_desc");
    				String category=(String)policy_details.get("category");
    				HashMap<String, String> company_details=db.getCompanyDetails(c_email);
    				%>
    				<p>
    				<img src='GetPhoto?email=<%=c_email%>&type=company' height='30'/>
    				Company Name: <%=company_details.get("name") %>
    				Company Phone: <%=company_details.get("phone") %>
    				Company Email: <%=c_email %>
    				</p>
    				<p>
    				Order ID: <%=oid %>
    				Policy ID: <%=pid %>
    				Name: <%=p_name %>
    				Sum Insured Amount: <%=p_si_amt %>
    				Description: <%=p_desc %>
    				</p>
    				<p>
    				Vehicle No.: <%=v_no %>
    				Category: <%=category %>
    				Engine No: <%=e_no %>
    				</p>
    			</div>
    		<%	
    		}
        	%>
       	</div>
            
        <footer class="bg-dark p-4">
          <p class="text-white">
            Design by <a href="https://www.incapp.in" target="_blank">INCAPP</a> &copy; Reights reserved
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Social Media: 
            <a href="https://facebook.com/incapp"><i class="fab fa-facebook"></i></a>
            &nbsp;
            <a href="https://instagram.com/incapp.in"><i class="fab fa-instagram"></i></a>
          </p>
        </footer>

        
    </body>
</html>
<% 
	}else{
		session.setAttribute("msg","Plz Login!");
		response.sendRedirect("index.jsp");
	}
%>