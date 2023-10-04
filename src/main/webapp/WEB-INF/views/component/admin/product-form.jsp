<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="site-product">
	<div class="row">
		<div class="col-xs-12 col-md-7">
			<form class="row g-3 needs-validation" novalidate>
				<div class="col-12">
					<label for="validationCustom01" class="form-label">Tên sản
						phẩm:</label> <input type="text" class="form-control"
						id="validationCustom01" value="" required>
					<div class="valid-feedback">Looks good!</div>
				</div>
				<div class="col-md-6">
					<label for="validationCustom02" class="form-label">Last
						name</label> <input type="text" class="form-control"
						id="validationCustom02" value="Otto" required>
					<div class="valid-feedback">Looks good!</div>
				</div>
				<div class="col-md-6">
					<label for="validationCustomUsername" class="form-label">Username</label>
					<div class="input-group">
						<span class="input-group-text" id="inputGroupPrepend">@</span> <input
							type="text" class="form-control" id="validationCustomUsername"
							aria-describedby="inputGroupPrepend" required>
						<div class="invalid-feedback">Please choose a username.</div>
					</div>
				</div>
				<div class="col-md-6">
					<label for="validationCustom03" class="form-label">City</label> <input
						type="text" class="form-control" id="validationCustom03" required>
					<div class="invalid-feedback">Please provide a valid city.</div>
				</div>
				<div class="col-md-3">
					<label for="validationCustom04" class="form-label">State</label> <select
						class="form-select" id="validationCustom04" required>
						<option selected disabled value="">Choose...</option>
						<option>...</option>
					</select>
					<div class="invalid-feedback">Please select a valid state.</div>
				</div>
				<div class="col-md-3">
					<label for="validationCustom05" class="form-label">Zip</label> <input
						type="text" class="form-control" id="validationCustom05" required>
					<div class="invalid-feedback">Please provide a valid zip.</div>
				</div>
				<div class="col-12">
					<div class="form-check">
						<input class="form-check-input" type="checkbox" value=""
							id="invalidCheck" required> <label
							class="form-check-label" for="invalidCheck"> Agree to
							terms and conditions </label>
						<div class="invalid-feedback">You must agree before
							submitting.</div>
					</div>
				</div>
				<div class="col-12">
					<label for="" class="form-label mb-3">Thông tin chi tiết:</label>
					<div class="describe row">
						<div class="col-xs-12 col-md-6 mb-3 ">
							<div class=" border border-1 p-3 position-relative">
								<span class="position-absolute z-3 bg-white" style="top: -13px">Mô
									tả 1:</span>
								<div class="mb-3">
									<div class="form-floating">
										<input type="text" class="form-control" id="tieude1"
											placeholder=""> <label for="tieude1">Tiêu đề:</label>
									</div>
								</div>
								<div class="form-floating">
									<textarea class="form-control"
										placeholder="Leave a comment here" id="floatingTextarea"
										style="height: 100px;"></textarea>
									<label for="floatingTextarea">Nội dung:</label>
								</div>
							</div>
						</div>
						<button type="button" class="button ms-2" onclick="themMoTa()">
							<span class="button__text">Thêm mô tả</span> <span
								class="button__icon"><svg
									xmlns="http://www.w3.org/2000/svg" width="24"
									viewBox="0 0 24 24" stroke-width="2" stroke-linejoin="round"
									stroke-linecap="round" stroke="currentColor" height="24"
									fill="none" class="svg">
                                                <line y2="19" y1="5"
										x2="12" x1="12"></line>
                                                <line y2="12" y1="12"
										x2="19" x1="5"></line>
                                            </svg></span>
						</button>
					</div>
				</div>
				<div class="col-12">
					<button class="btn btn-primary" type="submit">Submit form</button>
				</div>

			</form>
		</div>
		<div class="col-xs-12 col-md-5">
			<div class="mb-3">
				<label for="file" class="form-label">Hình ảnh:</label>
				<ul id="imageList">
					<li class="" style="list-style: none;"><label
						class="custum-file-upload" for="file">
							<div class="icon">
								<svg xmlns="http://www.w3.org/2000/svg" fill=""
									viewBox="0 0 24 24">
                                            <g stroke-width="0"
										id="SVGRepo_bgCarrier"></g>
                                            <g stroke-linejoin="round"
										stroke-linecap="round" id="SVGRepo_tracerCarrier">
                                            </g>
                                            <g id="SVGRepo_iconCarrier">
                                                <path fill=""
										d="M10 1C9.73478 1 9.48043 1.10536 9.29289 1.29289L3.29289 7.29289C3.10536 7.48043 3 7.73478 3 8V20C3 21.6569 4.34315 23 6 23H7C7.55228 23 8 22.5523 8 22C8 21.4477 7.55228 21 7 21H6C5.44772 21 5 20.5523 5 20V9H10C10.5523 9 11 8.55228 11 8V3H18C18.5523 3 19 3.44772 19 4V9C19 9.55228 19.4477 10 20 10C20.5523 10 21 9.55228 21 9V4C21 2.34315 19.6569 1 18 1H10ZM9 7H6.41421L9 4.41421V7ZM14 15.5C14 14.1193 15.1193 13 16.5 13C17.8807 13 19 14.1193 19 15.5V16V17H20C21.1046 17 22 17.8954 22 19C22 20.1046 21.1046 21 20 21H13C11.8954 21 11 20.1046 11 19C11 17.8954 11.8954 17 13 17H14V16V15.5ZM16.5 11C14.142 11 12.2076 12.8136 12.0156 15.122C10.2825 15.5606 9 17.1305 9 19C9 21.2091 10.7909 23 13 23H20C22.2091 23 24 21.2091 24 19C24 17.1305 22.7175 15.5606 20.9844 15.122C20.7924 12.8136 18.858 11 16.5 11Z"
										clip-rule="evenodd" fill-rule="evenodd"></path>
                                            </g>
                                        </svg>
							</div>
							<div class="text">
								<span>Tải ảnh lên</span>
							</div> <input type="file" id="file" multiple accept=".jpg, .jpeg, .png">
					</label></li>
				</ul>
			</div>
		</div>
	</div>

</div>