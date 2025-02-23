workspace "Cyber-2D"
	architecture "x86_64"
	startproject "Cyber-Editor"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

	flags
	{
		"MultiProcessorCompile"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "Cyber-2D/vendor/GLFW/include"
IncludeDir["Glad"] = "Cyber-2D/vendor/Glad/include"
IncludeDir["ImGui"] = "Cyber-2D/vendor/imgui"
IncludeDir["glm"] = "Cyber-2D/vendor/glm"
IncludeDir["stb_image"] = "Cyber-2D/vendor/stb_image"
IncludeDir["entt"] = "Cyber-2D/vendor/entt/include"
IncludeDir["python"] = "packages/python.3.9.4/tools/include"
IncludeDir["PyGLM"] = "Cyber-2D/vendor/PyGLM"
IncludeDir["ImGuizmo"] = "Cyber-2D/vendor/ImGuizmo"
IncludeDir["yaml_cpp"] = "Cyber-2D/vendor/yaml-cpp/include"


group "Dependencies"
	include "Cyber-2D/vendor/GLFW"
	include "Cyber-2D/vendor/Glad"
  include "Cyber-2D/vendor/imgui"
	include "Cyber-2D/vendor/yaml-cpp"
group ""

project "Cyber-2D"
	location "Cyber-2D"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "pch.h"
	pchsource "Cyber-2D/src/pch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.c",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/vendor/stb_image/**.h",
		"%{prj.name}/vendor/stb_image/**.cpp",
		"%{prj.name}/vendor/PyGLM/**.h",
		"%{prj.name}/vendor/PyGLM/**.c",
		"%{prj.name}/vendor/PyGLM/**.cpp",
		"%{prj.name}/vendor/glm/glm/**.hpp",
		"%{prj.name}/vendor/glm/glm/**.inl",
		"%{prj.name}/vendor/ImGuizmo/ImGuizmo.h",
		"%{prj.name}/vendor/ImGuizmo/ImGuizmo.cpp"
	}

	defines
	{
		"_CRT_SECURE_NO_WARNINGS",
		"GLFW_INCLUDE_NONE"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.glm}",
		"%{IncludeDir.stb_image}",
		"%{IncludeDir.entt}",
		"%{IncludeDir.python}",
    "%{IncludeDir.PyGLM}",
    "%{IncludeDir.ImGuizmo}",
		"%{IncludeDir.yaml_cpp}",
	}

	links
	{
		"GLFW",
		"Glad",
    "ImGui",
		"yaml-cpp",
		"opengl32.lib",
		"packages/python.3.9.4/tools/libs/python39.lib"
	}

	filter "system:windows"
		systemversion "latest"

		defines
		{
			"CB_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines {"CB_DEBUG","CB_CONSOLE"}
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines {"CB_RELEASE","CB_CONSOLE"}
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "CB_RELEASE"
		runtime "Release"
		optimize "on"

	filter "files:**.c"
		flags {"NoPCH"}

	filter "files:**/vendor/**.cpp"
		flags {"NoPCH"}

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.c",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/resources.rc"
	}

	includedirs
	{
		"Cyber-2D/vendor/spdlog/include",
		"Cyber-2D/src",
		"Cyber-2D/vendor",
		"%{IncludeDir.glm}",
		"%{IncludeDir.ImGui}",
    "%{IncludeDir.entt}",
		"%{IncludeDir.python}",
		"%{IncludeDir.PyGLM}"
	}

	links
	{
		"Cyber-2D",
		"packages/python.3.9.4/tools/libs/python39.lib"
	}

  postbuildcommands {
		"{COPYFILE} ../packages/python.3.9.4/tools/python39.dll %{cfg.targetdir}",
		"{COPYDIR} assets %{cfg.targetdir}/assets"
	}

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		defines {"CB_DEBUG","CB_CONSOLE"}
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines {"CB_RELEASE","CB_CONSOLE"}
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "CB_RELEASE"
		runtime "Release"
		optimize "on"

project "Cyber-Editor"
	location "Cyber-Editor"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.c",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/resources.rc"
	}

	includedirs
	{
		"Cyber-2D/vendor/spdlog/include",
		"Cyber-2D/src",
		"Cyber-2D/vendor",
		"%{IncludeDir.glm}",
		"%{IncludeDir.entt}",
		"%{IncludeDir.python}",
		"%{IncludeDir.PyGLM}",
		"%{IncludeDir.ImGuizmo}"
	}

	links
	{
		"Cyber-2D",
		"packages/python.3.9.4/tools/libs/python39.lib"
	}

	postbuildcommands {
		"{COPYFILE} ../packages/python.3.9.4/tools/python39.dll %{cfg.targetdir}",
		"{COPYDIR} assets %{cfg.targetdir}/assets",
		"{MKDIR} %{cfg.targetdir}/temp"
	}

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		defines {"CB_DEBUG","CB_CONSOLE"}
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines {"CB_RELEASE","CB_CONSOLE"}
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "CB_RELEASE"
		runtime "Release"
		optimize "on"

