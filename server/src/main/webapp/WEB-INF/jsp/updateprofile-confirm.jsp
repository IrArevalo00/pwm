<%@ page import="password.pwm.config.value.data.FormConfiguration" %>
<%@ page import="password.pwm.http.tag.conditional.PwmIfTest" %>
<%@ page import="password.pwm.util.LocaleHelper" %>
<%@ page import="password.pwm.util.java.StringUtil" %>
<%@ page import="java.util.Map" %>
<%@ page import="password.pwm.http.PwmRequestAttribute" %>
<%--
  ~ Password Management Servlets (PWM)
  ~ http://www.pwm-project.org
  ~
  ~ Copyright (c) 2006-2009 Novell, Inc.
  ~ Copyright (c) 2009-2017 The PWM Project
  ~
  ~ This program is free software; you can redistribute it and/or modify
  ~ it under the terms of the GNU General Public License as published by
  ~ the Free Software Foundation; either version 2 of the License, or
  ~ (at your option) any later version.
  ~
  ~ This program is distributed in the hope that it will be useful,
  ~ but WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ~ GNU General Public License for more details.
  ~
  ~ You should have received a copy of the GNU General Public License
  ~ along with this program; if not, write to the Free Software
  ~ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  --%>

<!DOCTYPE html>
<%@ page language="java" session="true" isThreadSafe="true"
         contentType="text/html" %>
<%@ taglib uri="pwm" prefix="pwm" %>
<html lang="<pwm:value name="<%=PwmValue.localeCode%>"/>" dir="<pwm:value name="<%=PwmValue.localeDir%>"/>">
<%@ include file="fragment/header.jsp" %>
<body class="nihilo">
<% final PwmRequest pwmRequest = JspUtility.getPwmRequest(pageContext);%>
<div id="wrapper">
    <jsp:include page="fragment/header-body.jsp">
        <jsp:param name="pwm.PageName" value="Title_UpdateProfileConfirm"/>
    </jsp:include>
    <div id="centerbody">
        <div id="page-content-title"><pwm:display key="Title_UpdateProfileConfirm" displayIfMissing="true"/></div>
        <p><pwm:display key="Display_UpdateProfileConfirm"/></p>
        <%@ include file="fragment/message.jsp" %>
        <br/>
        <% final Map<FormConfiguration,String> formDataMap = (Map<FormConfiguration,String>)JspUtility.getAttribute(pageContext, PwmRequestAttribute.FormData); %>
        <table id="ConfirmProfileTable">
            <% for (final Map.Entry<FormConfiguration, String> entry : formDataMap.entrySet()) { %>
            <% final FormConfiguration formConfiguration = entry.getKey(); %>
            <tr>
                <td class="key">
                    <%=formConfiguration.getLabel(JspUtility.locale(request))%>
                </td>
                <td>
                    <%
                        final String value = entry.getValue();
                        if (formConfiguration.getType() == FormConfiguration.Type.checkbox) {
                    %>
                    <label class="checkboxWrapper">
                        <input id="<%=formConfiguration.getName()%>" name="<%=formConfiguration.getName()%>" disabled type="checkbox" <%=(Boolean.parseBoolean(value))?"checked":""%>/>
                    </label>
                    <% } else { %>
                    <%=StringUtil.escapeHtml(formConfiguration.displayValue(value, JspUtility.locale(request), JspUtility.getPwmRequest(pageContext).getConfig()))%>
                    <% } %>
                </td>
            </tr>
            <% } %>

        </table>
        <div class="buttonbar">
            <form style="display: inline" action="<pwm:current-url/>" method="post" name="confirm" enctype="application/x-www-form-urlencoded" class="pwm-form">
                <button id="confirmBtn" type="submit" class="btn" name="button">
                    <pwm:if test="<%=PwmIfTest.showIcons%>"><span class="btn-icon pwm-icon pwm-icon-check"></span></pwm:if>
                    <pwm:display key="Button_Confirm"/>
                </button>
                <input type="hidden" name="processAction" value="confirm"/>
                <input type="hidden" name="pwmFormID" value="<pwm:FormID/>"/>
            </form>
            <form style="display: inline" action="<pwm:current-url/>" method="post" name="confirm" enctype="application/x-www-form-urlencoded"
                  class="pwm-form">
                <button id="gobackBtn" type="submit" class="btn" name="button">
                    <pwm:if test="<%=PwmIfTest.showIcons%>"><span class="btn-icon pwm-icon pwm-icon-backward"></span></pwm:if>
                    <pwm:display key="Button_GoBack"/>
                </button>
                <input type="hidden" name="processAction" value="unConfirm"/>
                <input type="hidden" name="pwmFormID" value="<pwm:FormID/>"/>
            </form>
        </div>
    </div>
    <div class="push"></div>
</div>
<%@ include file="fragment/footer.jsp" %>
</body>
</html>