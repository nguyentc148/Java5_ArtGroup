<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div class="content-profile">
	<div
		class="title  border border-right-0 border-top-0 border-left-0 py-2">
		<span class="display-6">Đổi mật khẩu</span>
	</div>
	<div class="main-content p-3">
		<form action="change-password" method="post" id="formChangePass">
			<div class="form-group mb-3">
				<label for="currentPass" class="form-label ">Mật khẩu hiện
					tại:</label> <input type="password"
					class="form-control "
					id="currentPass" name="currentPass" placeholder=""
					required="required">
					 <small class="text-danger d-none"
					id="currentPassError"></small>
			</div>

			<div class="form-group mb-3">
				<label for="newPassword" class="form-label ">Mật khẩu mới:</label> <input
					type="password"
					class="form-control "
					id="newPassword" name="newPassword" placeholder=""
					required="required">
					<small class="text-danger d-none"
					id="newPasswordError"></small>
			</div>

			<div class="form-group mb-3">
				<label for="confirmPassword" class="form-label ">Nhập lại
					mật khẩu mới:</label> <input type="password"
					class="form-control "
					id="confirmPassword" name="confirmPassword" placeholder=""
					required="required">
					<small class="text-danger d-none"
					id="confirmPasswordError"></small>
			</div>

			<div class="d-grid gap-2 mx-auto mb-3">
				<button class="btn" type="submit">Cập nhật</button>
			</div>
		</form>
	</div>
</div>