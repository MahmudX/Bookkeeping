using Infrastructure;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);
{
    builder.Services.AddInfrastructure(builder.Configuration);
    builder.Services.AddControllers();
    builder.Services.AddEndpointsApiExplorer();
    builder.Services.AddSwaggerGen();
}
WebApplication app = builder.Build();
{
    if (app.Environment.IsDevelopment())
    {
        app.UseSwagger();
        app.UseSwaggerUI();
    }

    app.UseHttpsRedirection();
    app.UseCors(options =>
    {
        // For local test
        // In production, origin should be specified
        options.AllowAnyHeader()
            .AllowAnyMethod().AllowAnyOrigin();
    });
    
    app.UseAuthentication();
    app.UseAuthorization();
    app.MapControllers();
    app.Run();
}