package v1

import (
	"github.com/gin-gonic/gin"

	"github.com/EngineerProOrg/BE-K07/internal/app/web_app/service"
)

func AddPostRouter(r *gin.RouterGroup, svc *service.WebService) {
	routerGroup := r.Group("posts")

	routerGroup.GET(":post_id", svc.GetPost)
	routerGroup.POST("", svc.CreatePost)
	routerGroup.PUT(":post_id", svc.EditPost)
	routerGroup.DELETE(":post_id", svc.DeletePost)
	routerGroup.POST(":post_id/comments", svc.CreatePostComment)
	routerGroup.POST(":post_id/likes", svc.LikePost)
}
