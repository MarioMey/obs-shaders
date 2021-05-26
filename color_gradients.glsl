/* Some color gradients
 */
vec4 render(vec2 st) {
    st.x *= builtin_uv_size.x/builtin_uv_size.y;

    vec3 color = vec3(st.x,st.y,abs(sin(builtin_elapsed_time)));

    return vec4(color,1.0);
}
