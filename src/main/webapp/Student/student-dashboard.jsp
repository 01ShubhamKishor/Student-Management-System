<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Student Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
.card{ border-radius:16px; box-shadow:0 4px 12px rgba(0,0,0,0.08); border:none; }
.profile{ width:90px; height:90px; border-radius:50%; background:#0d6efd; color:#fff; display:flex; align-items:center; justify-content:center; font-size:40px; margin:auto; }
</style>
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-primary">
  <div class="container">
    <span class="navbar-brand fw-bold">MyCollege</span>
    <a href="${pageContext.request.contextPath}/logout" class="btn btn-light btn-sm">Logout</a>
  </div>
</nav>

<div class="container mt-3">

  <div class="card p-3 text-center mb-3">
    <div class="profile">A</div>
    <h5 class="mt-2 mb-0">Aman Kumar</h5>
    <small class="text-muted">BCA-2023-045 | BCA</small><br>
    <span class="badge bg-success mt-2">Student</span>
  </div>

  <div class="row g-2 mb-3">
    <div class="col-6"><div class="card p-3 text-center"><small>Semester</small><h5>4th</h5></div></div>
    <div class="col-6"><div class="card p-3 text-center"><small>Total Fee</small><h5>₹45,000</h5></div></div>
    <div class="col-4"><div class="card p-2 text-center"><small>Attendance</small><b>78%</b></div></div>
    <div class="col-4"><div class="card p-2 text-center"><small>Pending Fee</small><b>₹5,000</b></div></div>
    <div class="col-4"><div class="card p-2 text-center"><small>Result</small><b>7.8 CGPA</b></div></div>
  </div>

  <div class="card p-3 mb-3">
    <h6>Personal Info</h6>
    <p class="mb-1"><b>Email:</b> aman@gmail.com</p>
    <p class="mb-1"><b>Phone:</b> 9876543210</p>
    <p class="mb-1"><b>DOB:</b> 15-05-2003</p>
    <p class="mb-0"><b>Address:</b> Delhi, India</p>
  </div>

  <div class="row g-2">
    <div class="col-6"><button class="btn btn-primary w-100">My Courses</button></div>
    <div class="col-6"><button class="btn btn-outline-primary w-100">Pay Fee</button></div>
    <div class="col-6"><button class="btn btn-outline-dark w-100">Attendance</button></div>
    <div class="col-6"><button class="btn btn-outline-dark w-100">Results</button></div>
  </div>

</div>
</body>
</html>