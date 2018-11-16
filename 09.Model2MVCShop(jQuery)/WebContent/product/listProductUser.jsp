<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>        

<html><head>

<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script>
<!--
function showInputField(){
	document.getElementById("minPrice").value = '';
	document.getElementById("maxPrice").value = '';
	document.getElementById("searchKeyword").value = '';
	if (document.getElementById("searchCondition").value == '1'){
		document.getElementById("priceInput").style.display="none";
		document.getElementById("searchKeyword").style.display="inline";
	}
	
	if (document.getElementById("searchCondition").value == '2'){
		document.getElementById("priceInput").style.display="inline";
		document.getElementById("searchKeyword").style.display="none";
	}
}

function checkPriceInput(){
	if (document.getElementById("searchCondition").value != '2') {
		fncGetItemList('1');
		return;
	}
	
	if (document.getElementById("minPrice").value != null && document.getElementById("minPrice").value.length>0 &&
			document.getElementById("maxPrice").value != null && document.getElementById("maxPrice").value.length>0
			&& document.getElementById("minPrice").value<=document.getElementById("maxPrice").value) {
		document.getElementById("searchKeyword").value = document.getElementById("minPrice").value+"-"+document.getElementById("maxPrice").value;
		fncGetItemList('1');
		return;
	}
	
	alert("�˸��� ���� ������ �������ּ���");
}
-->

$(function(){
	$('form[name="detailForm"]').attr("method","post").attr("action","/product/listProduct");
	$("#filterCondition, #sortCondition").on("change" , function() {
		fncGetItemList('1');
	});
	
	$("#searchCondition").on("change" , function() {
		showInputField();
	});
	
	$("td.ct_btn01:contains('�˻�')").on("click" , function() {
		checkPriceInput();
	});
	
	$(".ct_list_pop td:nth-child(3)").on("click", function(){
		var prodNo = $(this).data('param1');
		var tranCode = $(this).data('param2');
		if (tranCode =='' || tranCode == null) {
			self.location = "/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}";
		}
	})	
})
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<input type="hidden" id="menu" name="menu" value="${param.menu}"/>

<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">��ǰ �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select id="filterCondition" name="filterCondition" class="ct_input_g" style="width:80px">
				<option value="4" ${!empty search.filterCondition && search.filterCondition == "4" ? 'selected' : ''}>��� ��ǰ</option>
				<option value="0" ${!empty search.filterCondition && search.filterCondition == "0" ? 'selected' : ''}>�Ǹ���</option>
			</select>
			<select id="sortCondition" name="sortCondition" class="ct_input_g" style="width:100px">
				<option value="0" ${!empty search.sortCondition && search.sortCondition == "0" ? 'selected' : ''}>�Ż�ǰ��</option>
				<option value="1" ${!empty search.sortCondition && search.sortCondition == "1" ? 'selected' : ''}>�������ݼ�</option>
				<option value="2" ${!empty search.sortCondition && search.sortCondition == "2" ? 'selected' : ''}>�������ݼ�</option>
			</select>
			<select id="searchCondition" name="searchCondition" id="searchCondition" class="ct_input_g" style="width:80px">
				<option value="1" ${!empty search.searchCondition && search.searchCondition == "1" ? 'selected' : ''}>��ǰ��</option>
				<option value="2" ${!empty search.searchCondition && search.searchCondition == "2" ? 'selected' : ''}>��ǰ����</option>
			</select>
			<input type="text" name="searchKeyword" id="searchKeyword" value="${!empty search.searchKeyword ? search.searchKeyword : ''}" class="ct_input_g" style="width:200px; height:19px; display:${search.searchCondition == '2' ? 'none':'inline'}" />
			<div id="priceInput" style="display:${!empty search.searchKeyword && search.searchCondition == '2' ? 'inline' : 'none'}" align="right" width="210">
				<input type="text" name="minPrice" id="minPrice" value="${!empty search.searchKeyword ? fn:split(search.searchKeyword, '-')[0] : ''}" class="ct_input_g" style="width:100px; height:19px"/>
				-
				<input type="text" name="maxPrice" id="maxPrice" value="${!empty search.searchKeyword ? fn:split(search.searchKeyword, '-')[1] : ''}" class="ct_input_g" style="width:100px; height:19px"/>
			</div>
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
		<td class="ct_list_b">��ǰ������</td>	
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
			<td align="left" data-param1="${product.prodNo}" data-param2="${product.proTranCode}">
				${product.prodName}
			</td>
			<td></td>
			<td align="left">${product.price}</td>
			<td></td>
			<td align="left">${product.prodDetail}</td>
			<td></td>
			<td align="left">${product.proTranCode == null ? '�Ǹ���':'��� ����'}</td>
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