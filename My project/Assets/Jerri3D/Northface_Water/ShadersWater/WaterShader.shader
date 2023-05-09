Shader "Custom/WaterShader" {
    Properties{
        _MainTex("Texture", 2D) = "white" {}
        _NormalMap("Normal Map", 2D) = "bump" {}
        _WaveSpeed("Wave Speed", Range(0, 50)) = 0.1
        _WaveHeight("Wave Height", Range(0, 50)) = 0.5
        _WaveLength("Wave Length", Range(0, 50)) = 0.2
        _Depth("Depth", Range(0, 10)) = 0.5
        _Color("Color", Color) = (1,1,1,1)
        _Metallic("Metallic", Range(0,1)) = 0.0
        _Smoothness("Smoothness", Range(0,1)) = 0.5
    }

        SubShader{
            Tags { "RenderType" = "Opaque" }
            LOD 100

            CGPROGRAM
            #pragma surface surf Standard
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            sampler2D _NormalMap;
            float _WaveSpeed;
            float _WaveHeight;
            float _WaveLength;
            float _Depth;
            fixed4 _Color;
            float _Metallic;
            float _Smoothness;

            struct Input {
                float2 uv_MainTex;
                float3 worldPos;
                float3 worldNormal;
                INTERNAL_DATA
            };

            void surf(Input IN, inout SurfaceOutputStandard o) {
                // Get wave offset based on time and position
                float waveOffset = _Time.y * _WaveSpeed + dot(IN.worldPos, float3(1,0,1)) * _WaveLength;

                // Get normal map value and unpack it
                half4 normalMap = tex2D(_NormalMap, IN.uv_MainTex);
                float3 worldNormal = UnpackNormal(normalMap);

                // Add wave effect to vertex position
                IN.worldPos += worldNormal * _WaveHeight * sin(waveOffset);

                // Set surface output properties
                o.Albedo = tex2D(_MainTex, IN.uv_MainTex) * _Color;
                o.Metallic = _Metallic;
                o.Smoothness = _Smoothness;
                o.Normal = worldNormal;
                o.Alpha = 1.0;
                o.Emission = 0.0;
            }
            ENDCG
        }
            FallBack "Diffuse"
}
