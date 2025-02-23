#pragma once

#include <glm/glm.hpp>

namespace Cyber {

	class Camera
	{
	public:
		Camera() = default;
		Camera(const glm::mat4& projection, const glm::mat4& view)
			: m_ProjectionMatrix(projection), m_ViewMatrix(view)
		{
			m_ViewProjectionMatrix = m_ProjectionMatrix * m_ViewMatrix;
		}
		virtual ~Camera() = default;
		void SetProjectionMatrix(const glm::mat4& projection) {
			m_ProjectionMatrix = projection;
			m_ViewProjectionMatrix = m_ProjectionMatrix * m_ViewMatrix;
		}
		void SetViewMatrix(const glm::mat4& view) {
			m_ViewMatrix = view;
			m_ViewProjectionMatrix = m_ProjectionMatrix * m_ViewMatrix;
		}
		const glm::mat4& GetProjectionMatrix() const { return m_ProjectionMatrix; }
		const glm::mat4& GetViewMatrix() const { return m_ViewMatrix; }
		const glm::mat4& GetViewProjectionMatrix() const { return m_ViewProjectionMatrix; }
		glm::vec2 NormalizedToWorld(glm::vec2 point) const {
			glm::vec4 point4 = { point.x , point.y, 0, 1 };
			glm::mat4 inv = glm::inverse(GetViewMatrix() * GetProjectionMatrix());
			return point4 * inv;
		}
	protected:
		glm::mat4 m_ProjectionMatrix;
		glm::mat4 m_ViewMatrix;
		glm::mat4 m_ViewProjectionMatrix;
	};

}