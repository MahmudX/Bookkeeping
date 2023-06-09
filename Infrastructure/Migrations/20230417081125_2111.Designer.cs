﻿// <auto-generated />
using System;
using Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace Infrastructure.Migrations
{
    [DbContext(typeof(ApplicationDbContext))]
    [Migration("20230417081125_2111")]
    partial class _2111
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.5")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("Domain.Entities.Cost", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<int>("Year")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.ToTable("Costs");
                });

            modelBuilder.Entity("Domain.Entities.ExpenseType", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("ExpenseTypes");
                });

            modelBuilder.Entity("Domain.Entities.FinancialRecordBase", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid?>("CostId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Discriminator")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<Guid?>("IncomeId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<int>("Month")
                        .HasColumnType("int");

                    b.Property<decimal>("Value")
                        .HasColumnType("decimal(18,2)");

                    b.HasKey("Id");

                    b.HasIndex("CostId");

                    b.HasIndex("IncomeId");

                    b.ToTable("FinancialRecordBase");

                    b.HasDiscriminator<string>("Discriminator").HasValue("FinancialRecordBase");

                    b.UseTphMappingStrategy();
                });

            modelBuilder.Entity("Domain.Entities.Income", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<int>("Year")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.ToTable("Incomes");
                });

            modelBuilder.Entity("Domain.Entities.IncomeType", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("IncomeTypes");
                });

            modelBuilder.Entity("Domain.Entities.FinancialRecord", b =>
                {
                    b.HasBaseType("Domain.Entities.FinancialRecordBase");

                    b.Property<Guid?>("ExpenseTypeId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid?>("IncomeTypeId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<int>("Year")
                        .HasColumnType("int");

                    b.HasIndex("ExpenseTypeId");

                    b.HasIndex("IncomeTypeId");

                    b.HasDiscriminator().HasValue("FinancialRecord");
                });

            modelBuilder.Entity("Domain.Entities.FinancialRecordBase", b =>
                {
                    b.HasOne("Domain.Entities.Cost", null)
                        .WithMany("FinancialRecords")
                        .HasForeignKey("CostId");

                    b.HasOne("Domain.Entities.Income", null)
                        .WithMany("FinancialRecords")
                        .HasForeignKey("IncomeId");
                });

            modelBuilder.Entity("Domain.Entities.FinancialRecord", b =>
                {
                    b.HasOne("Domain.Entities.ExpenseType", null)
                        .WithMany("FinancialRecords")
                        .HasForeignKey("ExpenseTypeId");

                    b.HasOne("Domain.Entities.IncomeType", null)
                        .WithMany("FinancialRecords")
                        .HasForeignKey("IncomeTypeId");
                });

            modelBuilder.Entity("Domain.Entities.Cost", b =>
                {
                    b.Navigation("FinancialRecords");
                });

            modelBuilder.Entity("Domain.Entities.ExpenseType", b =>
                {
                    b.Navigation("FinancialRecords");
                });

            modelBuilder.Entity("Domain.Entities.Income", b =>
                {
                    b.Navigation("FinancialRecords");
                });

            modelBuilder.Entity("Domain.Entities.IncomeType", b =>
                {
                    b.Navigation("FinancialRecords");
                });
#pragma warning restore 612, 618
        }
    }
}
