<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="br.com.fatecpg.setcc.Course" %>
<%
    String pathList = request.getContextPath();
    /*String error = null;*/
    boolean alterTable = false;

    if (request.getParameter("formAlterTable") != null) {
        alterTable = true;
    }

    if (request.getParameter("formUpdateCourse") != null) {
        long id = Long.parseLong(request.getParameter("idALT"));
        String nome = request.getParameter("nameALT");

        try {
            Course.altCourse(id, nome);

            response.sendRedirect(pathList + "/courseList.jsp");
        } catch (Exception e) {
            /*error = e.getMessage();*/
        }
    }

    if (request.getParameter("formDeleteCourse") != null) {
        try {
            long idRM = Long.parseLong(request.getParameter("idRM"));
            Course.removeCourse(idRM);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e) {
            /*error = e.getMessage();*/
        }
    }

%>
<!DOCTYPE html>
<html lang="pt-br" class="no-js">
<head>
    <!-- Meta, Font e CSS -->
    <%@include file="WEB-INF/jspf/head.jspf"%>
    <!-- CSS Table -->
    <%@include file="WEB-INF/jspf/head-table.jspf"%>
    <!-- Site Title -->
    <title>Lista de Cursos - SETCC</title>
</head>
<body>

<% if (session.getAttribute("user") == null) { %>
<% response.sendRedirect(pathList + "/login.jsp"); %>
<% } else { %>

<!-- Menu -->
<%@include file="WEB-INF/jspf/menu.jspf" %>

<!-- Banner page up - begin -->
<%@include file="WEB-INF/jspf/banner-page-up.jspf"%>
<h1 class="text-white">
    Lista de Cursos
</h1>
<p class="text-white link-nav"><a href="index.jsp">Home </a> <span class="lnr lnr-arrow-right"></span> <a href="courseList.jsp"> Lista de Cursos</a></p>
<%@include file="WEB-INF/jspf/banner-page-down.jspf"%>
<!-- Banner page up - end -->


<div class="limiter"><!-- Lista de Cursos -->
    <div class="container-table100">
        <div class="wrap-table100">
            <div class="table100 ver3 m-b-110">
                <table data-vertable="ver3">
                    <thead>
                    <%if(!alterTable) {%>
                    <tr class="row100 head">
                        <th class="column100 column2" data-column="column2">ID</th>
                        <th class="column100 column1" data-column="column1">Curso</th>
                        <th class="column100 column1" data-column="column1">ID Temporada</th>
                        <th class="column100 column5" data-column="column3">Alterar</th>
                        <th class="column100 column6" data-column="column4">Apagar</th>
                    </tr>
                    </thead>
                    <% for(Course c: Course.getCourses()) { %>
                    <tbody>
                    <tr class="row100">
                        <td class="column100 column2" data-column="column2"><%= c.getId() %></td>
                        <td class="column100 column1" data-column="column1"><%= c.getNameCourse() %></td>
                        <td class="column100 column1" data-column="column1"><%= c.getIdSeason() %></td>
                        <td class="column100 column5" data-column="column3">
                            <form action="<%=pathList%>/courseList.jsp#jumpAlt" method="post">
                                <input type="hidden" name="idALT" value="<%= c.getId() %>"/>
                                <input type="hidden" name="nameALT" value="<%= c.getNameCourse() %>"/>
                                <input type="submit" name="formAlterTable" value="Alterar" class="genric-btn success"/>
                            </form>
                        </td>
                        <td class="column100 column6" data-column="column6">
                            <form>
                                <input type="hidden" name="idRM" value="<%= c.getId() %>"/>
                                <input type="submit" name="formDeleteCourse" value="Remover" class="genric-btn danger"/>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                    <% } else { %>
                    <div class="row d-flex justify-content-center">
                        <div class="col-md-12 pb-40 header-text text-center">
                            <form class="contact100-form validate-form">
                            <h1 id="jumpAlt" class="contact100-form-title">Alterando Informações de <%= request.getParameter("nameALT") %></h1>

                    <tr class="row100 head">
                        <th class="column100 column2" data-column="column2">ID</th>
                        <th class="column100 column1" data-column="column1">Nome</th>
                        <th class="column100 column5" data-column="column3">Alterar</th>
                    </tr>
                    </thead>
                    <%--<% for(User u: User.getUsers()) { %>--%>
                    <tbody>
                    <tr class="row100">
                            <form action="<%=pathList%>/courseList.jsp" method="post">
                            <td class="column100 column2" data-column="column2">
                                <%= request.getParameter("idALT") %>
                                <input type="hidden" name="idALT" value="<%= request.getParameter("idALT") %>"/>
                            </td>
                            <td class="column100 column1" data-column="column1">
                                <input id="name" class="input100" type="text" name="nameALT" value="<%= request.getParameter("nameALT") %>">
                            </td>
                            <td class="column100 column5" data-column="column3">
                                <input type="submit" name="formUpdateCourse" value="Salvar Alterações" class="genric-btn success"/>
                            </td>
                        </form>
                    </tr>
                    <%--<% } %>--%>
                    <% } %>
                    </tbody>
                </table>
            </form>
            </div>
        </div>
            </div>
        </div>
    </div>
</div>

<% } %>

<!-- Footer -->
<%@include file="WEB-INF/jspf/footer.jspf"%>

<!-- JavaScript Table -->
<%@include file="WEB-INF/jspf/scripts-table.jspf"%>
<!-- JavaScript -->
<%@include file="WEB-INF/jspf/scripts.jspf"%>
</body>
</html>



