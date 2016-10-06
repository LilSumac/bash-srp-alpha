/*  Credit to Author. from FP.  */
local PANEL = {}

function PANEL:Init()
    self.Avatar = vgui.Create("AvatarImage", self)
    self.Avatar:SetPaintedManually(true)
end

function PANEL:PerformLayout()
    self.Avatar:SetSize(self:GetWide(), self:GetTall())

    local sin, cos, rad = math.sin, math.cos, math.rad

    local function GeneratePoly(x, y, radius, quality)
        local circle = {}
        local tmp = 0
        for i = 1, quality do
            tmp = rad( i * 360) / quality
            circle[i] = {x = x + cos(tmp) * radius, y = y + sin(tmp) * radius}
        end
        return circle
    end  

    self.Poly = GeneratePoly(self:GetWide()/2, self:GetTall()/2, self:GetWide()/2, self:GetWide()*2)
end

function PANEL:Paint(w, h)
    render.ClearStencil() 

    render.SetStencilEnable(true)
    render.SetStencilWriteMask( 1 )
    render.SetStencilTestMask( 1 )
    render.SetStencilFailOperation( STENCILOPERATION_REPLACE )
    render.SetStencilPassOperation( STENCILOPERATION_ZERO )
    render.SetStencilZFailOperation( STENCILOPERATION_ZERO )
    render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_NEVER )
    render.SetStencilReferenceValue( 1 )

    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawPoly(self.Poly)

    render.SetStencilFailOperation( STENCILOPERATION_ZERO )
    render.SetStencilPassOperation( STENCILOPERATION_REPLACE )
    render.SetStencilZFailOperation( STENCILOPERATION_ZERO )
    render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
    render.SetStencilReferenceValue( 1 )

    self.Avatar:SetPaintedManually(false)
    self.Avatar:PaintManual()
    self.Avatar:SetPaintedManually(true)

    render.SetStencilEnable(false)
    render.ClearStencil()
end

vgui.Register("DRoundedAvatar", PANEL)