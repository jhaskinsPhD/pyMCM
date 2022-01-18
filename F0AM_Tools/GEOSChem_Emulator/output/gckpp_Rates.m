% Begin Rate Law Functions from KPP_HOME./util./UserRateLaws

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%  User-defined Rate Law functions
%  Note: the default argument type for rate laws, as read from the equations file, is single precision
%        but all the internal calculations are performed in double precision
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%~~~>  Arrhenius
function [ARR] = ARR( A0,B0,C0 )
%      REAL A0,B0,C0      
      ARR =  double(A0) .* exp(-double(B0)./TEMP) .* (TEMP./300.0).^double(C0);
end

%~~~> Simplified Arrhenius, with two arguments
%~~~> Note: The argument B0 has a changed sign when compared to ARR
function [ARR2] = ARR2( A0,B0 )
%      REAL A0,B0           
      ARR2 =  double(A0) .* exp( double(B0)./TEMP )              ;
end

function [EP2] = EP2(A0,C0,A2,C2,A3,C3)
%      REAL A0,C0,A2,C2,A3,C3
%      REAL(kind=dp) K0,K2,K3            
      K0 = double(A0) .* exp(-double(C0)./TEMP);
      K2 = double(A2) .* exp(-double(C2)./TEMP);
      K3 = double(A3) .* exp(-double(C3)./TEMP);
      K3 = K3.*CFACTOR.*1.0E6;
      EP2 = K0 + K3./(1.0+K3./K2 );
end

function [EP3] = EP3(A1,C1,A2,C2)
%      REAL A1, C1, A2, C2
%      REAL(kind=dp) K1, K2      
      K1 = double(A1) .* exp(-double(C1)./TEMP);
      K2 = double(A2) .* exp(-double(C2)./TEMP);
      EP3 = K1 + K2.*(1.0E6.*CFACTOR);
end

function [FALL] = FALL ( A0,B0,C0,A1,B1,C1,CF)
%      REAL A0,B0,C0,A1,B1,C1,CF
%      REAL(kind=dp) K0, K1     
      K0 = double(A0) .* exp(-double(B0)./TEMP).* (TEMP./300.0).^double(C0);
      K1 = double(A1) .* exp(-double(B1)./TEMP).* (TEMP./300.0).^double(C1);
      K0 = K0.*CFACTOR.*1.0E6;
      K1 = K0./K1;
      FALL = (K0./(1.0+K1)).*   ...
           double(CF).^(1.0./(1.0+(log1(K1)).^2));
end

  %---------------------------------------------------------------------------

function [k_3rd] = k_3rd(TEMP,cair,k0_300K,n,kinf_300K,m,fc)

    %INTRINSIC log1

    %REAL(kind=dp), INTENT(IN) :: TEMP      % TEMPerature [K]
    %REAL(kind=dp), INTENT(IN) :: cair      % air concentration [molecules./cm3]
    %REAL, INTENT(IN) :: k0_300K   % low pressure limit at 300 K
    %REAL, INTENT(IN) :: n         % exponent for low pressure limit
    %REAL, INTENT(IN) :: kinf_300K % high pressure limit at 300 K
    %REAL, INTENT(IN) :: m         % exponent for high pressure limit
    %REAL, INTENT(IN) :: fc        % broadening factor (usually fc=0.6)
    %REAL(kind=dp) :: zt_help, k0_T, kinf_T, k_ratio

    zt_help = 300./TEMP;
    k0_T    = k0_300K   .* zt_help.^(n) .* cair ;% k_0   at current T
    kinf_T  = kinf_300K .* zt_help.^(m)        ;% k_inf at current T
    k_ratio = k0_T./kinf_T;
    k_3rd   = k0_T./(1.+k_ratio).*fc.^(1./(1.+log1(k_ratio).^2));

end

  %---------------------------------------------------------------------------

function [k_arr] = k_arr (k_298,tdep,TEMP)
    % Arrhenius function

    %REAL,     INTENT(IN) :: k_298 % k at T = 298.15K
    %REAL,     INTENT(IN) :: tdep  % TEMPerature dependence
    %REAL(kind=dp), INTENT(IN) :: TEMP  % TEMPerature

    %INTRINSIC exp

    k_arr = k_298 .* exp(tdep.*(1./TEMP-3.3540e-3)) ;% 1./298.15=3.3540e-3

end

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%  End of User-defined Rate Law functions
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% End Rate Law Functions from KPP_HOME./util./UserRateLaws


% Begin INLINED Rate Law Functions



function [rate] = ARRPLUS_ade( a0, d0, e0 )
    % Modified Arrhenius law, skipping computation of exp( -b0./T )
    % and ( 300./T ).^c0 terms, which evaluate to 1 when b0 = c0 = 0.
    % This avoids excess CPU cycles. (bmy, 12./18./20)
    %
    % Used to compute the rate for these reactions:
    %    IHOO1 + IHOO1 = 2MVK  + 2HO2 + 2CH2O
    %    IHOO4 + IHOO4 = 2MACR + 2HO2 + 2CH2O
    %    IHOO1 + IHOO4 = MACR + MVK + 2HO2 + 2CH2O
    %    IHOO1 + IHOO1 = HO2 + HC5A + CO + OH +  MVKHP
    %    IHOO4 + IHOO4 = HO2 + HC5A + CO + OH +  MCRHP
    %    IHOO1 + IHOO4 = HO2 + HC5A + CO + OH +  0.5MVKHP + 0.5MCRHP
    %    IHOO1 + MO2   = MVK + 2HO2 + 2CH2O :
    %    IHOO1 + MO2   = CH2O + 0.5HC5A + 1.5HO2 + 0.5MVKHP + 0.5CO + 0.5OH
    %    IHOO4 + MO2   = MACR + 2HO2 + 2CH2O
    %    IHOO4 + MO2   = CH2O + 0.5HC5A + 1.5HO2 +  0.5MCRHP + 0.5CO + 0.5OH
    %
    %REAL(kind=dp), INTENT(IN) :: a0, d0, e0
    %REAL(kind=dp)             :: rate
    %
    rate = a0 .* ( d0 + ( TEMP .* e0 ) );
    rate = max( rate, 0.0 );
end

function [rate] = ARRPLUS_abde( a0, b0, d0, e0 )
    % Modified Arrhenius law, skipping computation of ( T./300 ).^c0,
    % which evaluates to 1 when c0=0.  This avoids excess CPU cycles.
    % (bmy, 12./18./20)
    %
    % Used to compute the rate for these reactions:
    %    IHOO1 + HO2 = 0.063MVK + 0.063OH + 0.063HO2 + 0.063CH2O + 0.937RIPA
    %    IHOO1 + HO2 = RIPC
    %    IHOO4 + HO2 = 0.063MACR + 0.063OH + 0.063HO2 + 0.063CH2O + 0.937RIPB
    %    IHOO4 + HO2 = RIPD
    %    IHOO1       = CH2O + OH + MVK
    %    IHOO4       = MACR + OH + CH2O
    %
    %REAL(kind=dp), INTENT(IN) :: a0, b0, d0, e0
    %REAL(kind=dp)             :: rate
    %
    rate = a0 .* ( d0 + ( TEMP .* e0 ) ) .* exp( -b0 ./ TEMP );
    rate = max( rate, 0.0 );
end

function [rate] = TUNPLUS_abcde( a0, b0, c0, d0, e0 )
    % Used to compute the rate for these reactions:
    %    IHOO1 = 1.5OH + ...
    %    IHOO4 = 1.5OH + ...
    %
    %REAL(kind=dp), INTENT(IN) :: a0, b0, c0, d0, e0
    %REAL(kind=dp)             :: rate
    %
    rate = a0 .* ( d0 + ( TEMP .* e0 ) );
    rate = rate .* exp( b0 ./ TEMP ) .* exp( c0 ./ TEMP.^3 );
    rate = max( rate, 0.0 );
end

function [rate] = GC_ISO1( a0, b0, c0, d0, e0, f0, g0 )
    % Used to compute the rate for these reactions:
    %    ISOP + OH = LISOPOH + IHOO1
    %    ISOP + OH = LISOPOH + IHOO4
    %
    %REAL(kind=dp), INTENT(IN) :: a0, b0, c0, d0, e0, f0, g0
    %REAL(kind=dp)             :: k0, k1, k2, rate
    %
    k0   = d0 .* exp( e0 ./ TEMP ) .* exp( 1.0E8 ./ TEMP.^3 );
    k1   = f0 .* exp( g0 ./ TEMP );
    k2   = c0 .* k0 ./ ( k0 + k1 );
    rate = a0 .* exp( b0 ./ TEMP ) .* ( 1.0 - k2 );
end

function [rate] = GC_ISO2( a0, b0, c0, d0, e0, f0, g0 )
    % Used to compute the rate for these reactions:
    %    ISOP + OH = 0.3MCO3 + 0.3MGLY + 0.3CH2O
    %              + 0.15HPALD3 + 0.25HPALD1 + 0.4HO2
    %              + 0.6CO + 1.5OH + 0.3HPETHNL + LISOPOH
    %    ISOP + OH = 0.3CH2O + 0.15HPALD4 + 0.25HPALD2
    %              + 1.5OH + 0.9CO + 0.7HO2 + 0.3MGLY
    %              + 0.3ATOOH + LISOPOH
    %
    %REAL(kind=dp), INTENT(IN) :: a0, b0, c0, d0, e0, f0, g0
    %REAL(kind=dp)             :: k0, k1, k2, rate
    %
    k0   = d0 .* exp( e0 ./ TEMP ) .* exp( 1.0E8 ./ TEMP.^3 );
    k1   = f0 .* exp( g0 ./ TEMP );
    k2   = c0 .* k0 ./ ( k0 + k1 );
    rate = a0 .* exp( b0 ./ TEMP ) .* k2;
end

function [rate] = GC_EPO_a( a1, e1, m1 )
    % Used to compute the rate for these reactions:
    %    RIPA   + OH = 0.67IEPOXA   + 0.33IEPOXB   + OH + 0.005LVOC
    %    RIPB   + OH = 0.68IEPOXA   + 0.321IEPOB   + OH + 0.005LVOC
    %    IEPOXA + OH = 0.67IEPOXA00 + 0.33IEPOXB00
    %    IEPOXB + OH = 0.81IEPOXA00 + 0.19IEPOXB00
    %    IHN2   + OH = 0.67IEPOXA   + 0.33IEPOXB   + NO2
    %    IHN3   + OH = 0.67IEPOXA   + 0.33IEPOXB   + NO2
    %    IHN1   + OH = IEPOXD       + NO2
    %    IHN4   + OH = IEPOXD       + NO2
    %    INPB   + OH = OH           + ITHN
    %    INPD   + OH = OH           + ITHN
    %    INPD   + OH = NO2          + ICHE
    %    ICN    + OH = NO2          + ICHE
    %
    %REAL(kind=dp), INTENT(IN) :: a1, e1, m1
    %REAL(kind=dp)             :: k1, rate
    %
    k1   = 1.0 ./ ( m1 .* NUMDEN + 1.0 );
    rate = a1 .* exp( e1 ./ TEMP ) .*  K1;
end

function [rate] = GC_PAN_acac( a0, c0, a1, c1, cf )
    % Used to compute the rate for these reactions:
    %    MACR1OO + NO2 = MPAN
    %    MACRNO2 + NO2 = MPAN + NO2
    %
    % For these reactions, these Arrhenius law terms evaluate to 1:
    %    exp(b0./T)
    %    exp(b1./T)
    % because b0 = b1 = 0.  Therefore we can skip computing these
    % terms.  This avoids excess CPU cycles. (bmy, 12./18./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0, c0, a1, c1, cf
    %REAL(kind=dp)             :: k0, k1, kr, nc, f,  rate
    %
    k0   = a0 .* ( TEMP ./ 300.0 ).^c0;
    k1   = a1 .* ( TEMP ./ 300.0 ).^c1;
    k0   = k0 .* NUMDEN;
    kr   = k0 ./ k1;
    nc   = 0.75 - 1.27 .* ( log1( cf ) );
    f    = 10.0.^( log1( cf ) ./ ( 1.0 + ( log1( kr ) ./ nc ).^2 ) );
    rate = k0 .* k1 .* f ./ ( k0 + k1 );
end

function [rate] = GC_NIT( a0, b0, c0, n, x0, y0 )
    % Used to compute the rate for these reactions:
    %    IHOO1    + NO = IHN2
    %    IHOO4    + NO = IHN4
    %    IHPOO1   + NO = IHTN
    %    IHPOO2   + NO = IHTN
    %    IHPOO2   + NO = IHTN
    %    IEPOXAOO + NO = IHTN
    %    IEPOXBOO + NO = IHTN
    %    IHCOO    + NO = IHTN
    %    ISOPNOO1 + NO = IDN
    %    ISOPNOO2 + NO = IDN
    %    IDHNDOO1 + NO = IDN
    %    IDHNDOO2 + NO = IDN
    %    INO2B    + NO = IDN
    %    INO2D    + NO = IDN
    %    IHPNBOO  + NO = IDN
    %    IHPNDOO  + NO = IDN
    %    MVK0HOO  + NO = 0.438MVKN
    %    MCROHOO  + NO = MCRHN
    %
    %REAL(kind=dp), INTENT(IN) :: a0, b0, c0, n,  x0, y0
    %REAL(kind=dp)             :: k0, k1, k2, k3, k4, rate
    %
    k0   = 2.0e-22 .* exp( n );
    k1   = 4.3e-1 .* ( TEMP ./ 298.0 ).^(-8);
    k0   = k0 .* NUMDEN;
    k1   = k0 ./ k1;
    k2   = ( k0 ./ ( 1.0 + k1 ) ) ...
         .* 4.1e-1.^( 1.0 ./ ( 1.0 + ( log1(k1) ).^2) );
    k3   = k2 ./ ( k2 + c0 );
    k4   = A0 .* ( x0 - TEMP.*y0 );
    rate = k4 .* exp( b0 ./ TEMP ) .* k3;
    rate = max( rate, 0.0 );
end

function [rate] = GC_ALK( a0, b0, c0, n, x0, y0 )
    % Used to compute the rate for these reactions:
    %   IHOO1    + NO =      NO2 + ...
    %   IHOO4    + NO =      NO2 + ...
    %   IHP001   + NO =      NO2 + ...
    %   IHP002   + NO =      NO2 + ...
    %   IHP003   + NO =      NO2 + ...
    %   IEPOXAOO + NO =      NO2 + ...
    %   IEPOXBOO + NO =      NO2 + ...
    %   ICHOO    + NO =      NO2 + ...
    %   ISOPNOO1 + NO = 1.728NO2 + ...
    %   ISOPNOO2 + NO =      NO2 + ...
    %   IDHNDOO1 + NO =      NO2 + ...
    %   IDHNDOO2 + NO =      NO2 + ...
    %   IDHNBOO  + NO =      NO2 + ...
    %   IDHNDOO  + NO =      NO2 + ...
    %   INO2B    + NO = 2.000NO2 + ...
    %   INO2D    + NO =      NO2 + ...
    %   IHPNBOO  + NO = 1.065NO2 + ...
    %   IHPNDOO  + NO =      NO2 + ...
    %   MVKOHOO  + NO =      NO2 + ...
    %   MCROHOO  + NO =      NO2 + ...
    %
    %REAL(kind=dp), INTENT(IN) :: a0, b0, c0, n,  x0, y0
    %REAL(kind=dp)             :: k0, k1, k2, k3, k4, rate
    %
    k0   = 2.0e-22 .* exp( n );
    k1   = 4.3e-1 .* ( TEMP ./ 298.0).^(-8);
    k0   = k0 .* NUMDEN;
    k1   = k0 ./ k1;
    k2   = ( K0 ./ ( 1.0 +K1 ) )                                          ...
         .* 4.1e-1.^( 1.0 ./ ( 1.0 + ( log1( k1 ) ).^2) );
    k3   = c0./ ( k2 + c0 );
    k4   = a0 .* ( x0 - TEMP.*y0 );
    rate = k4 .* exp( b0 ./ TEMP ) .* k3;
    rate = max( rate, 0.0 );
end

function [rate] = GCARR_ab( a0, b0 )
    % Arrhenius function, skipping computation of exp( c0./T ),
    % which evaluates to 1 when c0=0.  This avoids excess CPU
    % cycles. (bmy, 12./18./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0, b0
    %REAL(kind=dp)             :: rate
    %
    rate = a0 .* ( 300.0 ./ TEMP ).^b0;
end

function [rate] = GCARR_ac( a0, c0 )
    % Arrhenius function, skipping computation of ( 300./T ).^b0,
    % which evaluates to 1 when b0=0.  This avoids excess CPU
    % cycles (bmy, 12./18./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0, c0
    %REAL(kind=dp)             :: rate
    %
    rate = a0 .* exp( c0 ./ TEMP );
end

function [rate] = GCARR_abc( a0, b0, c0 )
    % Arrhenius function, using all 3 terms.
    % Use this when a0, b0, c0 are all nonzero.
    %
    %REAL(kind=dp), INTENT(IN) :: a0, b0, c0
    %REAL(kind=dp)             :: rate
    %
    rate = a0 .* exp( c0 ./ TEMP ) .* ( 300.0 ./ TEMP ).^b0;
end

function [rate] = GC_HO2HO2_acac( a0, c0, a1, c1 )
    % Used to compute the rate for these reactions:
    %    HO2 + HO2 = H2O2 + O2
    %
    % For this reaction, these Arrhenius law terms evaluate to 1:
    %    (300./T).^b0
    %    (300./T).^b1
    % because b0 = b1 = 0.  Therefore we can skip computing these
    % terms.  This avoids excess CPU cycles. (bmy, 12./18./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0, c0, a1, c1
    %REAL(kind=dp)             :: r0, r1, rate
    %
    r0   = a0 .* exp( c0 ./ TEMP );
    r1   = a1 .* exp( c1 ./ TEMP );
    rate = ( r0     + r1         .* NUMDEN                           ) ...
         .* ( 1.0 + 1.4e-21 .* H2O    .* exp( 2200.0 ./ TEMP ) );
end

function [rate] = GC_TBRANCH_1_acac( a0, c0, a1, c1 )
    % Temperature Dependent Branching Ratio, used for reactions:
    %    MO2 + MO2 = CH2O  + MOH + O2
    %    MO2 + MO2 = 2CH2O + 2HO2
    %
    % For these reactions, these Arrhenius law terms evaluate to 1:
    %    (300./T).^b0
    %    (300./T).^b1
    % because b0 = b1 = 0.  Therefore we can skip computing these
    % terms.  This avoids excess CPU cycles. (bmy, 12./18./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0, c0, a1, c1
    %REAL(kind=dp)             :: r0, r1, rate
    %
    r0   = a0 .* exp( c0 ./ TEMP );
    r1   = a1 .* exp( c1 ./ TEMP );
    rate = r0 ./ ( 1.0 + r1 );
end

function [rate] = GC_TBRANCH_2_acabc( a0, c0, a1, b1, c1 )
    % Temperature Dependent Branching Ratio, used for reactions:
    %    C3H8 + OH = B3O2
    %    C3H8 + OH = A3O2
    %
    % For these reactions, this Arrhenius law term evaluates to 1:
    %    (300./T).^b0
    % because b0 = 0.  Therefore we can skip computing this
    % term.  This avoids excess CPU cycles. (bmy, 12./18./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0, c0, a1, b1, c1
    %REAL(kind=dp)             :: r0, r1, rate
    %
    r0   =  a0 .* exp( c0 ./ TEMP );
    r1   =  a1 .* exp( c1 ./ TEMP ) .* ( 300.0 ./ TEMP ).^b1;
    rate =  r0 ./ ( 1.0 + r1 );
end

function [rate] = GC_RO2HO2_aca( a0, c0, a1 )
    % Carbon Dependence of RO2+HO2, used in these reactions:
    %    A3O2 + HO2 = RA3P
    %    PO2  + HO2 = PP
    %    KO2  + HO2 = 0.150OH + 0.150ALD2 + 0.150MCO3 + 0.850ATOOH
    %    B3O2 + HO2 = RB3P
    %    PRN1 + HO2 = PRPN
    %
    % For these reactions, these Arrhenius law terms evaluate to 1:
    %    (300./T).^b0
    %    (300./T).^b1 .* exp(c1./T)
    % Because b0 = b1 = c1 = 0.  Therefore we can skip computing these
    % terms.  This avoids excess CPU cycles. (bmy, 12./18./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0, c0, a1
    %REAL(kind=dp)             :: rate
    %
    rate = a0 .* exp( c0 ./ TEMP );
    rate = rate .* ( 1.0 - exp( -0.245 .* a1 ) );
end

function [rate] = GC_DMSOH_acac( a0, c0, a1, c1 )
    % Reaction rate for:
    %    DMS + OH = 0.750SO2 + 0.250MSA + MO2
    %
    % For this reaction, these Arrhenius law terms evaluate to 1:
    %    (300./T).^b0
    %    (300./T).^b1
    % Because b0 = b1 = 0.  Therefore we can skip computing these
    % terms.  This avoids excess CPU cycles. (bmy, 12./18./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0, c0, a1, c1
    %REAL(kind=dp)             :: r0, r1, rate
    r0   = a0 .* exp( c0 ./ TEMP );
    r1   = a1 .* exp( c1 ./ TEMP );
    rate = ( r0 .* NUMDEN .* 0.2095e0 ) ./ ( 1.0 + r1 .* 0.2095e0 );
end

function [rate] = GC_GLYXNO3_ac( a0, c0 )
    % Reaction rate for:
    %    GLYX + NO3 = HNO3 + HO2 + 2CO
    %    i.e. the HO2 + 2.*CO branch
    %
    % For this reaction, this Arrhenius term evaluates to 1:
    %    (300./T).^b0
    % because b0 = 0.  Therefore we can skip computing this
    % term.  This avoids excess CPU cycles. (bmy, 12./18./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0, c0
    %REAL(kind=dp)             :: O2, rate
    %
    % ---  K = K1.*([O2]+3.5D18)./(2.*[O2]+3.5D18)
    O2   = NUMDEN .* 0.2095e0;
    rate = a0 .* exp( c0 ./ TEMP );
    rate = rate .* ( O2 + 3.5e18 ) ./ ( 2.0 .* O2 + 3.5e18 );
end

function [rate] = GC_OHHNO3_acacac( a0, c0, a1, c1, a2, c2 )
    % Used to compute the rate for these reactions:
    %    HNO3  + OH = H2O + NO3
    %    HONIT + OH = NO3 + HAC
    %
    % For these reactions, these Arrhenius law terms evaluate to 1:
    %    (300./T).^b0
    %    (300./T).^b1
    %    (300./T).^b2
    % Because b0 = b1 = b2 = 0.  Therefore we can skip computing
    % these terms.  This avoids excess CPU cycles. (bmy, 12./18./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0, c0, a1, c1, a2, c2
    %REAL(kind=dp)             :: r0, r1, r2, rate
    %
    % ---  OH + HNO3:   K = K0 + K3[M] ./ (1 + K3[M]./K2)  ------
    r0   = a0 .* exp( c0 ./ TEMP );
    r1   = a1 .* exp( c1 ./ TEMP );
    r2   = NUMDEN .* ( a2 .* exp( c2 ./ TEMP ) );
    rate = r0 + r2 ./ ( 1.0 + r2./r1 );
end

function [rate] = GC_GLYCOH_A_a( a0 )
    % Used to compute the rate for this reaction:
    %    GLYC + OH = 0.732CH2O + 0.361CO2  + 0.505CO    + 0.227OH
    %              + 0.773HO2  + 0.134GLYX + 0.134HCOOH
    % which is the "A" branch of GLYC + OH.
    %
    % For this reaction, these Arrhenius law terms evaluate to 1:
    %    (300./T).^b0 .* exp(c0./T)
    % Because b0 = c0 = 0.  Therefore we can skip computing these
    % terms.  This avoids excess CPU cycles. (bmy, 12./18./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0
    %REAL(kind=dp)             :: glyc_frac, rate
    exp_arg = -1.0 ./ 73.0;
    %
    glyc_frac = 1.0 - 11.0729 .* exp( exp_arg .* TEMP );
    glyc_frac = max( glyc_frac, 0.0 );
    rate      = a0 .* glyc_frac;
end

function [rate] = GC_GLYCOH_B_a( a0 )
    % Used to compute the rate for this reaction:
    %    GLYC + OH = HCOOH + OH + CO
    % which is the "B" branch of GLYC + OH.
    %
    % For this reaction, these Arrhenius law terms evaluate to 1:
    %    (300./T).^b0 .* exp(c0./T)
    % Because b0 = c0 = 0.  Therefore we can skip computing these
    % terms.  This avoids excess CPU cycles. (bmy, 12./18./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0
    %REAL(kind=dp)             :: glyc_frac, rate
    exp_arg = -1.0 ./ 73.0;
    %
    glyc_frac = 1.0 - 11.0729 .* exp( exp_arg .* TEMP );
    glyc_frac = max( glyc_frac, 0.0 );
    rate      = a0 .* ( 1.0 - glyc_frac );
end

function [rate] = GC_HACOH_A_ac( a0, c0 )
    % Used to compute the rate for this reaction:
    %    HAC + OH = MGLY + HO2
    % which is the "A" branch of HAC + OH.
    %
    % For this reaction, this Arrhenius law term evaluates to 1:
    %    (300./T).^b0
    % because b0 = 0.  Therefore we can skip computing this
    % term.  This avoids excess CPU cycles. (bmy, 12./18./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0, c0
    %REAL(kind=dp)             :: r0, hac_frac, rate
    exp_arg = -1.0 ./ 60.0;
    %
    r0       = a0 .* exp( c0 ./ TEMP );
    hac_frac = 1.0 - 23.7 .* exp( exp_arg .* TEMP );
    hac_frac = max( hac_frac, 0.0 );
    rate     = r0 .* hac_frac;
end

function [rate] = GC_HACOH_B_ac( a0, c0 )
    % Used to compute the rate for this reaction:
    %    HAC + OH = 0.5HCOOH + OH + 0.5ACTA + 0.5CO2 + 0.5CO + 0.5MO2
    % which is the "B" branch of HAC + OH.
    %
    % For this reaction, this Arrhenius law term evaluates to 1:
    %    (300./T).^b0
    % because b0 = 0.  Therefore we can skip computing this
    % term.  This avoids excess CPU cycles. (bmy, 12./18./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0, c0
    %REAL(kind=dp)             :: r0, hac_frac, rate
    exp_arg = -1.0 ./ 60.0;
    %
    r0       = a0 .* exp( c0 ./ TEMP );
    hac_frac = 1.0 - 23.7 .* exp( exp_arg .* TEMP );
    hac_frac = max( hac_frac, 0.0 );
    rate     = r0 .* ( 1.0 - hac_frac );
end

function [rate] = GC_OHCO_a( a0 )
    % Reaction rate for:
    %    OH + CO = HO2 + CO2 (cf. JPL 15-10)
    %
    % For this reaction, these Arrhenius law terms evaluate to 1:
    %    (300./T).^b0 .* exp(c0./T)
    % because b0 = c0 = 0.  Therefore we can skip computing these
    % terms.  This avoids excess CPU cycles. (bmy, 12./18./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0
    %
    %REAL(kind=dp)             :: r0,     klo1,   klo2,  khi1,    khi2
    %REAL(kind=dp)             :: xyrat1, xyrat2, blog1, blog2,   fexp1
    %REAL(kind=dp)             :: fexp2,  kco1,   kco2,  TEMP300, rate
    %
    TEMP300 = ( 300.0 ./ TEMP );
    r0      = a0 .* ( 1.0 + 0.6 .* 9.871E7 .* PRESS );
    klo1    = 5.9e-33 .* TEMP300;
    khi1    = 1.1e-12 .* TEMP300.^(-1.3);
    xyrat1  = klo1 .* NUMDEN ./ khi1;
    blog1   = log1( xyrat1 );
    fexp1   = 1.0 ./ ( 1.0 + blog1.*blog1 );
    kco1    = klo1 .* NUMDEN .* 0.6.^fexp1 ./ ( 1.0 + xyrat1 );
    klo2    = 1.5e-13;
    khi2    = 2.1e09 .* TEMP300.^(-6.1);
    xyrat2  = klo2 .* NUMDEN ./ khi2;
    blog2   = log1( xyrat2 );
    fexp2   = 1.0 ./ ( 1.0 + blog2.*blog2 );
    kco2    = klo2 .* 0.6.^fexp2 ./ ( 1.0 + xyrat2 );
    rate    = kco1 + kco2;
end

function [rate] = GC_RO2NO_A1_ac( a0, c0 )
    % Reaction rate for the "A" branch of these RO2 + NO reactions:
    %    MO2  + NO = MENO3
    % in which the "a1" parameter equals exactly 1.
    %
    % For these reactions, these Arrhenius law terms evaluate to 1:
    %    (300./T).^b0
    %    (300./T).^b1 .* exp(c1./T)
    % because b0 = b1 = c1 = 0.  Therefore we can skip computing
    % these terms.  This avoids excess CPU cycles. (bmy, 1./4./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0, c0
    fyrno3 = 3.0e-4;
    %REAL(kind=dp)             :: rate
    %
    % Special treatment for methyl nitrate based on observations
    % as Carter and Atkinson formulation does not apply to C1.
    % Value based on upper limit of Flocke et al. 1998 as applied
    % in Fisher et al. 2018
    rate  = a0 .* exp( c0 ./ TEMP ) .* fyrno3;
end

function [rate] = GC_RO2NO_B1_ac( a0, c0 )
    % Reaction rate for the "B" branch of these RO2 + NO reactions:
    %    MO2 + NO = CH2O + NO2 + HO2
    % in which the "a1" parameter equals exactly 1.
    %
    % For these reactions, these Arrhenius law terms evaluate to 1:
    %    (300./T).^b0
    %    (300./T).^b1 .* exp(c1./T)
    % because b0 = c0 = c1 = 0.  Therefore we can skip computing
    % these terms.  This avoids excess CPU cycles. (bmy, 1./4./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0, c0
    one_minus_fyrno3 = 1.0 - 3.0e-4;
    %REAL(kind=dp)             :: rate
    %
    rate = a0 .* exp( c0 ./ TEMP ) .* one_minus_fyrno3;
end

function [rate] = GC_RO2NO_A2_aca( a0, c0, a1 )
    % Reaction rate for the "A" branch of these RO2 + NO reactions,
    %    ETO2 + NO = ETNO3
    %    A3O2 + NO = NPRNO3
    %    R4O2 + NO = R4N2
    %    B3O2 + NO = IPRNO3
    % in which the "a1" parameter is greater than 1.0.
    %
    % For these reactions, these Arrhenius law terms evaluate to 1:
    %    (300./T).^b0
    %    (300./T).^b1 .* exp(c1./T)
    % because b0 = b1 = c1 = 0.  Therefore we can skip computing
    % these terms.  This avoids excess CPU cycles. (bmy, 1./4./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0,  c0,   a1
    %REAL(kind=dp)             :: r0,  rate, yyyn, xxyn
    %REAL(kind=dp)             :: aaa, rarb, zzyn, fyrno3
    %
    r0     = a0 .* exp( c0 ./ TEMP );
    xxyn   = 1.94e-22 .* exp( 0.97 .* a1 ) .* NUMDEN;
    yyyn   = 0.826 .* ( ( 300.0 ./ TEMP ).^8.1 );
    aaa    = log1( xxyn ./ yyyn );
    zzyn   = ( 1.0 ./ ( 1.0 + ( aaa .*  aaa  ) ) );
    rarb   = ( xxyn   ./ ( 1.0 + ( xxyn ./ yyyn ) ) ) .* ( 0.411.^zzyn );
    fyrno3 = ( rarb   ./ ( 1.0 +   rarb          ) );
    rate   = r0 .* fyrno3;
end

function [rate] = GC_RO2NO_B2_aca( a0, c0, a1 )
    % Reaction rate for the "B" branch of these RO2 + NO reactions:
    %    ETO2 + NO = NO2 +     HO2 + ...
    %    A3O2 + NO = NO2 +     HO2 + ...
    %    R4O2 + NO = NO2 + 0.27HO2 + ...
    %    B3O2 + NO = NO2 +     HO2 + ...
    % in which the "a1" parameter is greater than 1.0.
    %
    % For these reactions, these Arrhenius law terms evaluate to 1:
    %    (300./T).^b0
    %    (300./T).^b1 .* exp(c1./T)
    % because b0 = c0 = c1 = 0.  Therefore we can skip computing
    % these terms.  This avoids excess CPU cycles. (bmy, 1./4./20)
    %
    % Use this function when a1 input argument is greater than 1.0.
    % This avoids if statements, which saves CPU cycles (bmy, 1./4./20);; end 
    %
    %REAL(kind=dp), INTENT(IN) :: a0,  c0,   a1
    %REAL(kind=dp)             :: r0,  rate, yyyn, xxyn
    %REAL(kind=dp)             :: aaa, rarb, zzyn, fyrno3
    %
    r0     = a0 .* exp( c0 ./ TEMP );
    xxyn   = 1.94e-22 .* exp(  0.97 .* a1 ) .* NUMDEN;
    yyyn   = 0.826 .* ( ( 300.0 ./ TEMP ).^ 8.1 );
    aaa    = log1( xxyn ./ yyyn );
    zzyn   = ( 1.0 ./ ( 1.0 + ( aaa  .* aaa  ) ) );
    rarb   = ( xxyn   ./ ( 1.0 + ( xxyn ./ yyyn ) ) ) .* ( 0.411.^zzyn );
    fyrno3 = ( rarb   ./ ( 1.0 +   rarb          ) );
    rate   = r0 .* ( 1.0 - fyrno3 );
end

function [rate] = GCJPLEQ_acabab( a0, c0, a1, b1, a2, b2, fv )
    % Calculates the equilibrium constant
    % Find the backwards reaction by K=kforward./kbackwards
    % Calculates the rate constant of the forward reaction
    %
    % Used to compute the rate for these reactions:
    %    PPN        = RCO3 + NO2
    %    PAN        = MCO3 + NO2
    %    ClOO  {+M} = Cl   + O2 {+M}
    %    Cl2O2 {+M} = 2ClO      {+M}
    %
    % For these reactions, these Arrhenius law terms evaluate to 1:
    %    (300./T).^b0
    %    exp(c1./T)
    %    exp(c2./T)
    % because b0 = c1 = c2 = 0.  Therefore we can skip computing these terms.
    % Also, fct1 = fct2 = 0, so we will skip those terms as well.  This is
    % more computationally efficient. (bmy, 1./25./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a0, c0, a1, b1, a2, b2, fv
    %REAL(kind=dp)             :: r0, r1, rate
    %
    r0    = a0 .* exp( c0 ./ TEMP )               ;% backwards rxn rate
    r1    = GCJPLPR_abab( a1, b1, a2, b2, fv )  ;% forwards rxn rate
    rate  = r1 ./ r0;
end

function [rate] = GCJPLPR_aa( a1, a2, fv )
    % Third body effect for pressure dependence of rate coefficients.
    % a1 is Arrhenius parameters for the lower-limit rate.
    % a2 is Arrhenius parameters for the upper-limit rate.
    % fv is the falloff curve paramter, (see ATKINSON ET. AL (1992)
    % J. Phys. Chem. Ref. Data 21, P. 1145). Usually fv = 0.6.
    %
    % Used to compute the rate for this reaction:
    %    Cl + PRPE {+M} = HCl + PO2 {+M}
    %
    % For this reactions, these Arrhenius law terms evaluate to 1:
    %    (300./T).^b1 .* exp(c1./T)
    %    (300./T).^b2 .* exp(c2./T)
    % because b1 = b2 = c1 = c2 = 0.  Therefore we can skip computing
    % these terms.  Also, fct1 = fct2 = 0, so we will skip computing
    % these terms as well.  This is more computationally efficient.
    % (bmy, 1./25./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a1,   a2,   fv
    %REAL(kind=dp)             :: rlow, xyrat, blog, fexp, rate
    %
    rlow  = a1 .* NUMDEN;
    xyrat = rlow ./ a2         ;% rhigh = a2
    blog  = log1( xyrat );
    fexp  = 1.0 ./ ( 1.0 + ( blog .* blog ) );
    rate  = rlow .* ( fv.^fexp ) ./ ( 1.0 + xyrat );
end

function [rate] = GCJPLPR_aba( a1, b1, a2, fv )
    % Third body effect for pressure dependence of rate coefficients.
    % a1, b1 are the Arrhenius parameters for the lower-limit rate.
    % a2     is  the Arrhenius parameters for the upper-limit rate.
    % fv     is the falloff curve paramter, (see ATKINSON ET. AL (1992)
    %        J. Phys. Chem. Ref. Data 21, P. 1145). Usually fv = 0.6.
    %
    % Used to compute the rate for these reactions:
    %    OH  + OH  {+M} = H2O2
    %    NO2 + OH  {+M} = HNO3       {+M}
    %    Cl  + O2  {+M} = ClOO       {+M}
    %    SO2 + OH  {+M} = SO4  + HO2
    %    Br  + NO2 {+M} = BrNO2      {+M}
    %    NO  + O   {+M} = NO2        {+M}
    %    I   + NO2 {+M} = IONO       {+M}
    %    I   + NO  {+M} = INO        {+M}
    %
    % For these reactions, these Arrhenius law terms evaluate to 1:
    %    exp(c1./T)
    %    (300./T).^b2 .* exp(c2./T)
    % because b2 = c1 = c2 = 0.  Therefore we can skip computing these
    % terms.  Also, fct1 = fct2 = 0, so we will skip computing these
    % terms as well.  This is more computationally efficient.
    % (bmy, 1./25./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a1,   b1,    a2,    fv
    %REAL(kind=dp)             :: rlow, xyrat, blog, fexp, rate
    %
    rlow  = a1 .* ( ( 300.0 ./ TEMP ).^b1 ) .* NUMDEN;
    xyrat = rlow ./ a2                                  ;% rhigh = a2
    blog  = log1( xyrat );
    fexp  = 1.0 ./ ( 1.0 + ( blog .* blog ) );
    rate  = rlow .* ( fv.^fexp ) ./ ( 1.0 + xyrat );
end

function [rate] = GCJPLPR_abab( a1, b1, a2, b2, fv )
    % Third body effect for pressure dependence of rate coefficients.
    % a1, b1 are the Arrhenius parameters for the lower-limit rate.
    % a2, b2 are the Arrhenius parameters for the upper-limit rate.
    % fv     is the falloff curve paramter, (see ATKINSON ET. AL (1992)
    %        J. Phys. Chem. Ref. Data 21, P. 1145). Usually fv = 0.6.
    %
    % Used to compute the rate for these reactions:
    %    NO   + OH  {+M} = HNO2  {+M}
    %    HO2  + NO2 {+M} = HNO4
    %    NO2  + NO3 {+M} = N2O5
    %    ClO  + NO2 {+M} = ClNO3 {+M}
    %    MCO3 + NO2 {+M} = PAN
    %    RCO3 + NO2 {+M} = PPN
    %    PRPE + OH  {+M} = PO2
    %    MO2  + NO2 {+M} = MPN   {+M}
    %    BrO  + NO2 {+M} = BrNO3 {+M}
    %    NO2  + O   {+M} = NO3   {+M}
    %    H    + O2  {+M} = HO2   {+M}
    %    IO   + NO2 {+M} = IONO2 {+M}
    %
    % For these reactions, these Arrhenius law terms evaluate to 1:
    %    exp(c1./T)
    %    exp(c2./T)
    % because c1 = c2 = 0.  Therefore we can skip computing these
    % terms.  Also, fct1 = fct2 = 0, so we will skip computing these
    % terms as well.  This is more computationally efficient.
    % (bmy, 1./25./20)
    %
    %REAL(kind=dp), INTENT(IN) :: a1,   b1,    a2,    b2,   fv
    %REAL(kind=dp)             :: rlow, rhigh, xyrat, blog, fexp, rate
    %
    rlow  = a1 .* ( ( 300.0 ./ TEMP ).^b1 ) .* NUMDEN;
    rhigh = a2 .* ( ( 300.0 ./ TEMP ).^b2 );
    xyrat = rlow ./ rhigh;
    blog  = log1( xyrat );
    fexp  = 1.0 ./ ( 1.0 + ( blog .* blog ) );
    rate  = rlow .* ( fv.^fexp ) ./ ( 1.0 + xyrat );
end

function [rate] = GCJPLPR_abcabc( a1, b1, c1, a2, b2, c2, fv )
    % Third body effect for pressure dependence of rate coefficients.
    % a1, b1, c1 are the Arrhenius parameters for the lower-limit rate.
    % a2, b2, c2 are the Arrhenius parameters for the upper-limit rate.
    % fv         is the falloff curve paramter, (see ATKINSON ET. AL (1992)
    %           J. Phys. Chem. Ref. Data 21, P. 1145). Usually fv = 0.6.
    %
    % Used to compute the rate for these reactions:
    %    HNO4 {+M} = HO2 + NO2
    %    N2O5 {+M} = NO2 + NO3
    %    MPN  {+M} = MO2 + NO2
    %
    %REAL(kind=dp), INTENT(IN) :: a1,   b1,    c1,    a2,   b2,   c2,  fv
    %REAL(kind=dp)             :: rlow, rhigh, xyrat, blog, fexp, rate
    %
    rlow  = a1 .* ( ( 300.0 ./ TEMP ).^b1 ) .* exp( c1 ./ TEMP ) .* NUMDEN;
    rhigh = a2 .* ( ( 300.0 ./ TEMP ).^b2 ) .* exp( c2 ./ TEMP );
    xyrat = rlow ./ rhigh;
    blog  = log1( xyrat );
    fexp  = 1.0 ./ ( 1.0 + ( blog .* blog ) );
    rate  = rlow .* ( fv.^fexp ) ./ ( 1.0 + xyrat );
end

% End INLINED Rate Law Functions
