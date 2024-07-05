c_old = c_advection_old - lambda*u_old;
m_adv_old = diag(c_old)*CN;
u_dummy = u_old; 
u_new =  u_old + m_adv_old*u_old;
c_new = c_advection_new-lambda*u_new;
m_adv_new = diag(c_new)*CN; 
u_dummy = u_new;

 
u_new = u_old +max(c_old,0).*(upwind_neg*u_old)+min(c_old,0).*(upwind_pos*u_old);
u_old = u_new;


if ~true_sol
    m_adv_old = (eye(n)-(1-beta)*m_adv_new)\(eye(n)+beta*m_adv_old);
    sigma_u_new = m_adv_old*sigma_u_old*m_adv_old'+B^2*diag((CN*u_new).^2)*dt;
    sigma_u_old = sigma_u_new;
end
beta = 1;