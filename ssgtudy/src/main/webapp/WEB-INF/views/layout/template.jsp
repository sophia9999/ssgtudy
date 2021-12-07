<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<section class="row">
	<div class="card">
		<table class="table table-lg">
			<thead>
				<tr>
					<th>NAME</th>
					<th>RATE</th>
					<th>SKILL</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="text-bold-500">Michael Right</td>
					<td>$15/hr</td>
					<td class="text-bold-500">UI/UX</td>
				</tr>
				<tr>
					<td class="text-bold-500">Michael Right</td>
					<td>$15/hr</td>
					<td class="text-bold-500">UI/UX</td>
				</tr>
				<tr>
					<td class="text-bold-500">Michael Right</td>
					<td>$15/hr</td>
					<td class="text-bold-500">UI/UX</td>
				</tr>
				<tr>
					<td class="text-bold-500">Michael Right</td>
					<td>$15/hr</td>
					<td class="text-bold-500">UI/UX</td>
				</tr>
			</tbody>
		</table>
	                                            
		<form class="form form-horizontal">
			<div class="form-body">
				<div class="row"> 
					<div class="col-md-4 form-group">                                                           
					</div>                                      
					<div class="col-md-3 form-group">
						<input type="text" id="first-name" class="form-control" name="fname" placeholder="검색">                                          
					</div>
					<div class="col-md-1 form-group">                                                     
						<button type="button" class="btn btn-outline-primary me-1 mb-1">검색</button>
					</div>				                                                   
					<div class="col-md-4 d-flex justify-content-end">
						<button type="submit" class="btn btn-outline-primary me-1 mb-1">등록</button>
						<button type="reset" class="btn btn-outline-primary me-1 mb-1">취소</button>
					</div>
				</div>
			</div>
		</form>                              
	</div>   
</section>