package v1

import (
	"github.com/gin-gonic/gin"

	"github.com/EngineerProOrg/BE-K07/internal/app/web_app/service"
)

func AddUserRouter(r *gin.RouterGroup, svc *service.WebService) {
	userRouter := r.Group("users")
	userRouter.POST("login", svc.CheckUserNamePassword)
	userRouter.POST("", svc.CreateUser)
	userRouter.PUT("", svc.EditUser)
}
