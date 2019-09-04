Shader "Custom Shader/My Shader/Spot Light"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_CharacterPosition("Player pos",vector)=(0,0,0)
		_CircleRadius("SpotLight",Range(0,50))=1
		_RingSize("Ring Size",Range(0,10))=.5
		_colorTint("Color Tint",Color)=(0,0,0,0)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				float3 WorldPos:TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _CharacterPosition;
			float _RingSize;
			float _CircleRadius;
		    float4 _colorTint;

			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.WorldPos=mul(unity_ObjectToWorld,v.vertex).xyz;
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = _colorTint;
				float dist=distance(i.WorldPos,_CharacterPosition.xyz);
				if(dist<_CircleRadius)
				col=tex2D(_MainTex,i.uv);
				else if(dist>_CircleRadius&&dist<_CircleRadius+_RingSize)
			    {
					float BlendStrength=dist-_CircleRadius;
					col=lerp(tex2D(_MainTex,i.uv),_colorTint,BlendStrength/_RingSize);
				}
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}
