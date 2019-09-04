Shader "Custom Shader/My Shader/Outline"
{
	Properties
	{
        _Color("Color",color)=(0,0,0,0)
		_MainTex ("Texture", 2D) = "white" {}
		_OutlineColor("Outline Color",Color)=(0,0,0,1)
		_OutlineWidth("Outline Width",Range(0.0,2.0))=1.05
	}
	CGINCLUDE
	#include "UnityCG.cginc"
	struct appdata
	{
		float4 verex:POSITION;
		float3 Normal:NORMAL;
	};
	struct v2f
	{
		float4 pos:POSITION;
		float Normal:NORMAL;
	};
	float4 _OutlineColor;
	float _OutlineWidth;
	v2f vert(appdata v)
	{
		v.verex.xyz *=_OutlineWidth;
		v2f o;
		o.pos=UnityObjectToClipPos(v.verex);
		return o;
	}

	ENDCG

	SubShader
	{
	Tags{"Queue"="Transparent"}
		Pass
		{
			ZWrite Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			//float4 _OutlineColor;
			half4 frag(v2f i):COLOR
			{
				return _OutlineColor;
			}
			ENDCG
		}
		Pass
		{
		  ZWrite On
		  Material
		  {
		  	  Diffuse[_Color]
			  Ambient[_Color]
		  }
		  Lighting On
		  SetTexture[_MainTex]
		  {
		  	  ConstantColor[_Color]
		  }
		  SetTexture[_MainTex]
		  {
		  	Combine previous*primary DOUBLE
		  }
		}
	}
}
