<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<section id="footer" class="single-page">
    <div class="container">
        <div class="row span12">
            <article>
                <div class="status">
                    <div class="header">
                        <jsp:useBean id="status" class="com.blackpoints.struts.form.StatisticForm">
                            <fmt:formatNumber value="${status.countPOI}" type="NUMBER" maxFractionDigits="3" />
                        </jsp:useBean> 
                        <bean:message key="footer.header.location" />
                    </div>
                    <div class="desc"><bean:message key="footer.desc.location" /></div>
                </div>
                <div class="status">
                    <div class="header">
                        <fmt:formatNumber value="${status.countUser}" type="NUMBER" maxFractionDigits="3" />
                        <bean:message key="footer.header.user" />
                    </div>
                    <div class="desc"><bean:message key="footer.desc.user" /> <i class="fa fa-android"></i> <i class="fa fa-apple"></i> <i class="fa fa-laptop"></i></div>
                </div>
                <!--                <div class="status">
                                    <div class="header">434234 bình luận</div>
                                    <div class="desc">đã chia sẻ</div>
                                </div>-->
            </article>
            <div class="mobileapps">
                <div class="left-text">
                    <h2>Blackpoints App trên mobile</h2>
                    <p>Bạn có thể tìm bất kì điểm đen giao thông nào trên 64 tỉnh thành tại Việt Nam!</p>
                    <p>Với Blackpoints App, bạn có thể cập nhật liên tục thông tin điểm đen giao thông trên hành trình của mình.</p>
                </div>
                <div class="right-image">
                    <img src="img/footer-phones.png" alt="Blackpoints App trên mobile" />
                </div>
            </div>
        </div>
    </div>
</section>