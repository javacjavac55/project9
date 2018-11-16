<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        

<html><head>

<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script>
	$(function(){
		$('form[name="detailForm"]').attr("method","post").attr("action","/product/listProduct");
		$("#filterCondition").on("change" , function() {
			fncGetItemList('1');
		});
		
		$("td.ct_btn01:contains('�˻�')").on("click" , function() {
			fncGetItemList('1');
		});
		
		$(".ct_list_pop td:nth-child(3)").on("click", function(){
			var prodNo = $(this).data('param1');
			if (${param.menu == 'manage'}) {
				self.location = "/product/updateProduct?prodNo="+prodNo+"&menu=${param.menu}";
			} else {
				if (${user.role == 'admin'}){
					self.location = "/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}";
				} 
			}
		})
		
		$("#divy").on("click", function(){
			var prodNo = $(this).data('param1');
			self.location = "/purchase/updateTranCodeByProd?prodNo="+prodNo+"&tranCode=2";
		})
	
	})
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<input type="hidden" id="menu" name="menu" value="${param.menu}"/>

<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
	<tbody><tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tbody><tr>
					<c:if test="${param.menu == 'manage'}">
						<td width="93%" class="ct_ttl01">��ǰ ����</td>
					</c:if>
					<c:if test="${param.menu == 'search'}">
						<td width="93%" class="ct_ttl01">��ǰ �����ȸ</td>
					</c:if>
				</tr>
			</tbody></table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</tbody></table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select id="filterCondition" name="filterCondition" class="ct_input_g" style="width:80px">
				<option value="4" ${!empty search.filterCondition && search.filterCondition == "4" ? 'selected' : ''}>��� ��ǰ</option>
				<option value="0" ${!empty search.filterCondition && search.filterCondition == "0" ? 'selected' : ''}>�Ǹ���</option>
				<option value="1" ${!empty search.filterCondition && search.filterCondition == "1" ? 'selected' : ''}>���ſϷ�</option>
				<option value="2" ${!empty search.filterCondition && search.filterCondition == "2" ? 'selected' : ''}>�����</option>
				<option value="3" ${!empty search.filterCondition && search.filterCondition == "3" ? 'selected' : ''}>��ۿϷ�</option>
			</select>
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${!empty search.searchCondition && search.searchCondition == "0" ? 'selected' : ''}>��ǰ��ȣ</option>
				<option value="1" ${!empty search.searchCondition && search.searchCondition == "1" ? 'selected' : ''}>��ǰ��</option>
				<option value="2" ${!empty search.searchCondition && search.searchCondition == "2" ? 'selected' : ''}>��ǰ����</option>
			</select>
			<input type="text" name="searchKeyword" value="${!empty search.searchKeyword ? search.searchKeyword : ''}" class="ct_input_g" style="width:200px; height:19px" />
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						�˻�
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11">��ü  ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${i+1}" />
		<tr class="ct_list_pop">
			<td align="center">${i}</td>
			<td></td>
			<td align="left" data-param1="${product.prodNo}">${product.prodName}</td>
			<td></td>
			<td align="left">${product.price}</td>
			<td></td>
			<td align="left">${product.regDate}</td>
			<td></td>
			<td align="left">
				<c:if test="${product.proTranCode == null}">�Ǹ���</c:if>
				<c:if test="${product.proTranCode == '1'}">
					���ſϷ�
					<c:if test="${param.menu == 'manage'}">
						<span id="divy" data-param1="${product.prodNo}">����ϱ�</span>
					</c:if> 
				</c:if>
				<c:if test="${product.proTranCode == '2'}">�����</c:if>
				<c:if test="${product.proTranCode == '3'}">��ۿϷ�</c:if>
			</td>
		</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	</c:forEach>
	</tbody>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp"/>	
		</td>
	</tr>
</table>
<!--  ������ Navigator �� -->

</form>

</div>

</body></html>